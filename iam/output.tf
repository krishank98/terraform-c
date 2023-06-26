output "ec2_ami" {
  value = aws_instance.web.ami
}

output "instance_public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "pemkey" {
  value = aws_instance.web.key_name
}