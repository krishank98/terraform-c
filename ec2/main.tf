
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  owners = ["099720109477"]
}

data "aws_vpc" "default" {
  default = true
} 

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = "terraform-key-pair"
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]

  root_block_device {
    volume_size = var.disk_size
    volume_type = "gp2"
  }

  user_data = <<-EOF
#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo bash -c 'echo your very first web server > /var/www/html/index.html'
EOF

  tags = {
    Name = var.ec2_name
    Env  = var.env
  }
}