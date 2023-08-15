output "elb_address" {
    value = "${aws_lb.elb.dns_name}"
}
