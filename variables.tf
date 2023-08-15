variable "region" {
    type = string
    default = "us-east-1"
}

variable "az" {
    type = list
    default = ["us-east-1a", "us-east-1b"]
}

variable "key_name" {
    type = string
}

variable "public_cidr" {
    type = list
    default = ["10.0.0.0/25", "10.0.0.128/25"]
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "ami" {
    type = string
    default = "ami-08a52ddb321b32a8c"
}

variable "desired" {
    type = number
    default = 2
}

variable "min" {
    type = number
    default = 1
}

variable "max" {
    type = number
    default = 4
}

