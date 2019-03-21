resource  "aws_key_pair" "my_key_pair" {
  key_name  = "id_rsa"
  public_key  = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
