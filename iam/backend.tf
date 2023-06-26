terraform {
  backend "s3" {
    bucket = "terraform-buket-june-545"
    key    = "iam/terraform.state"
    region = "us-east-1"
  }
}
