# variables for the instance
variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = "map"

  default = {
    us-east-1 = "ami-06d990a360d7a793c"
    us-west-2 = "ami-0b4a4b368aa8bd6f0"
    eu-west-1 = "ami-01bc69b830b49f729"
  }
}
