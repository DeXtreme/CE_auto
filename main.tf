provider "aws" {
  region = "${var.region}"
}


resource "aws_launch_template" "tmpl" {
  name = "server-tmpl"
  description = "Template for auto scaling group"
  image_id = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  user_data = "${filebase64("./bootstrap.sh")}"

  network_interfaces {
    associate_public_ip_address = true 
    security_groups = ["${aws_security_group.server-sg.id}"]
  }

  
  
}

resource "aws_autoscaling_group" "ag" {
    name = "server-auto-group"
    min_size = "${var.min}"
    max_size = "${var.max}"
    desired_capacity = "${var.desired}"
    vpc_zone_identifier = "${aws_subnet.public.*.id}"
    target_group_arns = ["${aws_lb_target_group.server-tg.id}"]
    
    launch_template {
      id = "${aws_launch_template.tmpl.id}"
    }

}

resource "aws_autoscaling_policy" "agp" {
  name = "server-auto-policy"
  autoscaling_group_name = "${aws_autoscaling_group.ag.name}"
  #scaling_adjustment     = 1 only works for SimpleScaling 
  adjustment_type        = "PercentChangeInCapacity"
  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75
  }
}

resource "aws_lb_target_group" "server-tg" {
    name = "server-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_lb" "elb" {
  name = "server-elb"
  internal = false
  load_balancer_type = "application"
  subnets = "${aws_subnet.public.*.id}"
  security_groups = ["${aws_security_group.elb-sg.id}"]
}

resource "aws_lb_listener" "elb-ln" {
  load_balancer_arn = "${aws_lb.elb.arn}"
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.server-tg.arn}"
  }
}


