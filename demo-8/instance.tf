resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"

  # define vpc subnet
  subnet_id = "${aws_subnet.main_public_1.id}"

  # define SG
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]

  # public ssh key
  key_name = "${aws_key_pair.my_key_pair.key_name}"
}
