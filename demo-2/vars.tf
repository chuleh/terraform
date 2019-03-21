variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-west-2"
}

variable "AMIS" {
  type = "map"
  default = {
  us-west-2 = "ami-0b4a4b368aa8bd6f0"
}
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "id_rsa"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "id_rsa.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
