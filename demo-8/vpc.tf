# Internet VPC
resource "aws_vpc" "main" {
  cidr_block  = "10.0.0.0/16"
  instance_tenancy  = "default"
  enable_dns_support  = "true"
  enable_dns_hostnames  = "true"
  enable_classiclink  = "false"

  tags  {
  Name  = "main vpc"
}
}

# public subs
resource "aws_subnet" "main_public_1" {
  vpc_id  = "${aws_vpc.main.id}"
  cidr_block  = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-west-2a"

  tags {
  Name  = "main_public_1"
}
}

resource "aws_subnet" "main_public_2" {
  vpc_id  = "${aws_vpc.main.id}"
  cidr_block  = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-west-2d"

  tags {
  Name  = "main_public_2"
}
}


# private subs
resource "aws_subnet" "main_private_1" {
  vpc_id  = "${aws_vpc.main.id}"
  cidr_block  = "10.0.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-west-2a"

  tags {
  Name  = "main_private_1"
}
}

resource "aws_subnet" "main_private_2" {
  vpc_id  = "${aws_vpc.main.id}"
  cidr_block  = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-west-2d"

  tags {
  Name  = "main_private_2"
}
}

# internet gateway
resource "aws_internet_gateway" "main_gw" {
  vpc_id  = "${aws_vpc.main.id}"

  tags {
  Name  = "main_gw"
}
}

# route table
resource  "aws_route_table" "main_public_rt" {
  vpc_id  = "${aws_vpc.main.id}"
  route {
  cidr_block  = "0.0.0.0/0"
  gateway_id  = "${aws_internet_gateway.main_gw.id}"
}

  tags {
  Name  = "main_public_rt"
}
}

# route associations public
resource "aws_route_table_association"  "main_public_1_a" {
  subnet_id = "${aws_subnet.main_public_1.id}"
  route_table_id  = "${aws_route_table.main_public_rt.id}"
}

resource "aws_route_table_association"  "main_public_2_a" {
  subnet_id = "${aws_subnet.main_public_2.id}"
  route_table_id  = "${aws_route_table.main_public_rt.id}"
}
