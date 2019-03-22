resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform-state-chule"
  acl    = "private"

  tags {
    Name = "Terraform state"
  }
}
