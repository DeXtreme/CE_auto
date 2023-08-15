resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/24"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "vpc"
    }
}

resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "vpc-igw"
  }
}

resource "aws_route" "internet" {
    route_table_id = "${aws_vpc.vpc.main_route_table_id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc-igw.id}"
}

resource "aws_subnet" "public" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${var.public_cidr[count.index]}"
    availability_zone = "${var.az[count.index]}"
    
    tags = {
        Name = "public-${count.index}"
    }

    count = 2 //Create two subnets for ALB
}
