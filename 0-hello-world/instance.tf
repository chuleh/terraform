# set provider
provider "aws" {
  region = "us-east-1"
}

# create first instance
resource "aws_instance" "hello_world" {
  ami           = "ami-06d990a360d7a793c"
  instance_type = "t2.micro"
}
