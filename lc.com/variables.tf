# main variables for lc.com

variable "aws_region" {
  description = "region for the vpc"
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "172.50.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "172.50.20.0/24"
}

variable "ami" {
  description = "AMI for the instances"
  default = "ami-0ac019f4fcb7cb7e6"
}
