##############
# main tf file
##############

# define provider
provider "aws" {
  region = "${var.aws_region}"
}

# define VPC
resource "aws_vpc" "infra_aws_vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
  Name = "infra_aws_vpc"
}
}

# define public subnet
resource "aws_subnet" "public_subnets" {
  count = "${length(var.public_subnets_cidrs)}"
  vpc_id = "${aws_vpc.infra_aws_vpc.id}"
  cidr_block = "${var.public_subnets_cidrs[count.index]}"
  availability_zone = "${var.availability_zones[count.index]}"

  tags {
  Name = "${var.public_subnets_names[count.index]}"
}
}

# define routing table
resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.infra_aws_vpc.id}"

  tags {
  Name = "public routing table"
}
}

# associate subnets to routing table
resource "aws_route_table_association" "infra_aws_public_rt" {
  count = "${length(var.public_subnets_cidrs)}"
  subnet_id = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  route_table_id =  "${aws_route_table.public_rt.id}"
}

# define Internet Gateway
resource "aws_internet_gateway" "infra_aws_igw" {
  vpc_id = "${aws_vpc.infra_aws_vpc.id}"

  tags {
  Name = "Internet Gateway"
}
}

# define SG for public subnets
resource "aws_security_group" "infra_aws_sg" {
  description = "Allow all traffic to port 80 and only my IP on port 22"
  vpc_id = "${aws_vpc.infra_aws_vpc.id}"

  ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

  ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["186.18.32.107/32"]
}

  tags {
  Name = "main sg for aws infra"
}
}

# define two instances and their subnet
resource "aws_instance" "aws_infra_webservers" {
  ami = "${var.aws_ami}"
  instance_type = "t2.micro"
  count = 2
  security_groups = ["${aws_security_group.infra_aws_sg.id}"]
  associate_public_ip_address = true
  source_dest_check = false
  subnet_id = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  user_data = "${file("install.sh")}"

  tags {
    Name = "${var.instances_names[count.index]}"
  }
  }
