##################################################
# define: region - vpc - public subnet - IGW - etc
##################################################

# define provider
provider "aws" {
  region = "${var.aws_region}"
}

# define VPC
resource "aws_vpc" "vpc_qa" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
  Name = "vpc qa"
}
}

# define public_subnet
resource "aws_subnet" "pub_sub" {
  vpc_id = "${aws_vpc.vpc_qa.id}"
  cidr_block = "${var.public_subnet_cidr}"

  availability_zone = "us-east-1a"

  tags {
  Name = "public subnet"
}
}

# defined IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc_qa.id}"

  tags {
  Name = "Internet Gateway"
}
}

# define routing table
resource "aws_route_table" "web_public_rt" {
  vpc_id = "${aws_vpc.vpc_qa.id}"

  route {
  cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw.id}"
}

  tags {
  Name = "Public Subnet RT"
}
}

# associate route table to public subnet
resource "aws_route_table_association" "web_public_rt" {
  subnet_id = "${aws_subnet.pub_sub.id}"
  route_table_id = "${aws_route_table.web_public_rt.id}"
}

# define security group for the public subnet
resource "aws_security_group" "infra-aws-qa-sg" {
  description = "Allow all traffic on 80 and only my ip on 22"
  vpc_id  = "${aws_vpc.vpc_qa.id}"

  ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["186.18.32.107/32"]
  }

  ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
  tags {
  Name = "infra aws qa public sg"
}
}

# define first instance with the public subnet
resource "aws_instance" "wordpress1"{
  ami = "${var.ami}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.pub_sub.id}"
  security_groups = ["${aws_security_group.infra-aws-qa-sg.id}"]
  associate_public_ip_address = true
  source_dest_check = false
  user_data = "${file("install.sh")}"

  tags {
  Name = "infra aws qa"
}
}
