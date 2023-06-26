variable "region" {
  description = "region name"
  default     = "us-west-2"
}

variable "ec2_name" {
  description = "our ec2 instance name"
  default     = "june-instance-tf"
}


variable "instance_type" {
  description = "our ec2 instance type"
  default     = "t2.micro"
}

variable "disk_size" {
  description = "our ec2 instance disk size"
  default     = "20"
}

variable "env" {
  description = "env name"
  default     = "dev"
}