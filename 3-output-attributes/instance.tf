# will create a new instance that will output
# the public ip address to the terminal
# and will create a new file with the private ip of the instance.

# create the instance and run a local command
# that will create the private_ips txt file
# with local-exec. This will be done locally.
resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.private_ip} > private_ips"
  }
}

# add the output directive with the name "public_ip"
# this will print out the public ip of the instance
# when it finishes the run
output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}
