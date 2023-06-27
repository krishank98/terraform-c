resource "aws_security_group" "allow_ssh_http" {
  name = "allow_ssh_http"
  description = "allow ssh and http"
  vpc_id = data.aws_vpc.default.id

  ingress {
    description = "allowssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  ingress {
    description = "allowhttp"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  egress  {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    name = "allow_ssh_http"
  }
}