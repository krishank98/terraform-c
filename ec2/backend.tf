terraform {
  backend "s3" {
    bucket = "terraform-buket-june-545"
    key    = "ec2/terraform.state"
    region = "us-east-1"
  }
}