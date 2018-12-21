variable "aws_region" {
  description = "region for the vpc"
  default = "us-west-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default = "172.10.0.0/16"
}

variable "availability_zones" {
  description = "AZs in this region to use"
  default = ["us-west-1b", "us-west-1c"]
  type = "list"
}

variable "public_subnets_cidrs" {
  description = "Subnet CIDRS for public subnets"
  default = ["172.10.10.0/24", "172.10.20.0/24" ]
  type = "list"
}

variable "public_subnets_names" {
  description = "Subnets names"
  default = ["pub-sub-1", "pub-sub-2"]
  type = "list"
}

variable "aws_ami" {
  description = "Ubuntu 18.04"
  default = "ami-063aa838bd7631e0b"
}

variable "instances_names" {
  description = "names for the VMs"
  default = ["webserver1", "webserver2"]
  type = "list"
}