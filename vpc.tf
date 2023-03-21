resource "aws_vpc" "main" {
  cidr_block           = "90.90.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    "Name" = "My-${var.mytag}-vpc"
  }
}

resource "aws_subnet" "public-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "90.90.5.0/24"
  availability_zone = "us-east-1a"

  map_public_ip_on_launch = true # Enable assign public Ip
  tags = {
    Name = "my-${var.mytag}-public-1a"
  }
}

resource "aws_subnet" "public-1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "90.90.10.0/24"
  availability_zone = "us-east-1b"

  map_public_ip_on_launch = true # Enable assign public Ip
  tags = {
    "Name" = "my-${var.mytag}-public-1b"
  }
}

resource "aws_subnet" "private-1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "90.90.15.0/24"
  availability_zone = "us-east-1a"

  map_public_ip_on_launch = false # Default = false, no need to mention it if it private
  tags = {
    "Name" = "my-${var.mytag}-private-1a"
  }
}

resource "aws_subnet" "private-1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "90.90.20.0/24"
  availability_zone = "us-east-1b"

  map_public_ip_on_launch = false # Default = false, no need to mention it if it private
  tags = {
    "Name" = "my-${var.mytag}-private-1b"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.mytag}-GW"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "Public-route-t"
  }
}

resource "aws_route_table" "private_route" {

  vpc_id = aws_vpc.main.id

  route = [] # That's gonna be empty(private)
  tags = {
    Name = "Private-route-t"
  }
}

resource "aws_route_table_association" "public1a" {
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public1b" {
  subnet_id      = aws_subnet.public-1b.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "private1a" {
  subnet_id      = aws_subnet.private-1a.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnet.private-1b.id
  route_table_id = aws_route_table.private_route.id
}