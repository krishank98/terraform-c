resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
      Name = "main"
  }
}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "main"
    }
  
}

resource "aws_subnet" "pb-sub" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "pvt-sub" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "main"
  }
}



resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.main.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  
}

resource "aws_route_table_association" "rt_ass_pb" {
 subnet_id =   aws_subnet.pb-sub.id
 route_table_id = aws_route_table.rt-public.id
}

resource "aws_route_table" "rt-private" {
  vpc_id = aws_vpc.main.id
 
}

resource "aws_route_table_association" "rt_ass_pvt" {
 subnet_id =   aws_subnet.pvt-sub.id
 route_table_id = aws_route_table.rt-private.id
}