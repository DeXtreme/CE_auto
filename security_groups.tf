resource "aws_security_group" "elb-sg" {
  name = "elb-security-group"
  description = "Allow HTTP access"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "server-sg" {
    name = "server"
    description = "Allows SSH and HTTP access"
    vpc_id = "${aws_vpc.vpc.id}"

    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port = "0"
      to_port = "0"
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}