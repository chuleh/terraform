# main file for lc.com

# define provider
provider "aws" {
  region = "${var.aws_region}"
}

# define vpc
resource "aws_vpc" "lc_vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
  Name = "lc.com vpc"
}
}

# define public subnet
resource "aws_subnet" "lc_pub_sub" {
  vpc_id = "${aws_vpc.lc_vpc.id}"
  cidr_block = "{var.public_subnet_cidr}"
  availability_zone = "us-east-1a"

  tags {
  Name = "Public Subnet"
}
}

# define IGW
resource "aws_internet_gateway" "lc_igw" {
  vpc_id = "${aws_vpc.lc_vpc.id}"

  tags {
  Name = "lc IGW"
}
}

# define route table
resource "aws_route_table" "lc_rt" {
  vpc_id = "${aws_vpc.lc_vpc.id}"

  route {
  cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.lc_igw.id}"
}

  tags {
  Name = "Routing Table"
}
}

# associate route table to the public subnet
resource "aws_route_table_association" "lc_pub_sub_rt" {
  subnet_id = "${aws_subnet.lc_pub_sub.id}"
  route_table_id = "${aws_route_table.lc_rt.id}"
}

# Define the security group for public subnet
resource "aws_security_group" "lc_sg_web" {
  description = "Allow incoming HTTP connections & SSH access"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["186.18.32.107/32"]
  }

  vpc_id="${aws_vpc.lc_vpc.id}"

  tags {
    Name = "Web Server SG"
  }
}


# Define webserver inside the public subnet
resource "aws_instance" "lc_web" {
   ami  = "${var.ami}"
   instance_type = "t2.micro"
   subnet_id = "${aws_subnet.lc_pub_sub.id}"
   vpc_security_group_ids = ["${aws_security_group.lc_sg_web.id}"]
   associate_public_ip_address = true
   source_dest_check = false
   user_data = "${file("install.sh")}"

  tags {
    Name = "wordpress"
  }
}
