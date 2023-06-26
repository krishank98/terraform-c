variable "region" {
  description = "region name"
  default     = "us-west-2"
}

variable "username" {
  type = list(string)
  default = [ "krish","ram","shyam" ]
}