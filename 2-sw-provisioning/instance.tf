# main file for the instance
# must add the key and the username which we will use
# to connect to.

# define the key pair I'll use to log into the instance
resource "aws_key_pair" "id_rsa" {
  key_name   = "id_rsa"
  public_key = "${file("${var.PUBLIC_KEY}")}"
}

# create the instance
resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.id_rsa.key_name}"

  # upload the nginx script
  provisioner "file" {
    source      = "nginx.sh"
    destination = "/tmp/nginx.sh"
  }

  # make the script executable and run it
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/nginx.sh",
      "sudo /tmp/nginx.sh",
    ]
  }

  # connection defines the username we will use and the private key
  # for sshing into the instance
  connection {
    user        = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PRIVATE_KEY}")}"
  }
}
