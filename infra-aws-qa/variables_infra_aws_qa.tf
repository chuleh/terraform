################
# main variables
################

variable "aws_region" {
  description = "region for the vpc"
  default = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
	description = "CIDR for the Private Subnet"
	default = "10.0.2.0/24"
}

variable "ami" {
  description = "ubuntu 18.04"
  default = "ami-0bbe6b35405ecebdb"
}