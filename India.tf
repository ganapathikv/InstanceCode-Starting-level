provider "aws" {
  alias  = "india"
  region = "ap-south-1"
}

resource "aws_vpc" "India-testvpc-1" {
  provider             = aws.india
  cidr_block           = "10.40.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name        = "Terraform-VPC"
    Owner       = "GANA"
    environment = "PROD"
  }
}
resource "aws_internet_gateway" "India-testvpc-IGW" {
  provider = aws.india
  vpc_id   = aws_vpc.India-testvpc-1.id
  tags = {
    Name = "Terraform-VPC-IGW"
  }
}

resource "aws_subnet" "subnet1-public-India" {
  provider                = aws.india
  vpc_id                  = aws_vpc.India-testvpc-1.id
  cidr_block              = "10.40.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "testvpc-Subnet-1"
  }
}

resource "aws_subnet" "subnet2-public-India" {
  provider                = aws.india
  vpc_id                  = aws_vpc.India-testvpc-1.id
  cidr_block              = "10.40.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1b"

  tags = {
    Name = "testvpc-Subnet-2"
  }
}

resource "aws_subnet" "subnet3-public-India" {
  provider                = aws.india
  vpc_id                  = aws_vpc.India-testvpc-1.id
  cidr_block              = "10.40.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1c"

  tags = {
    Name = "testvpc-Subnet-3"
  }

}

resource "aws_route_table" "terraform-public-India" {
  provider = aws.india
  vpc_id   = aws_vpc.India-testvpc-1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.India-testvpc-IGW.id
  }

  tags = {
    Name = "India-testvpc-1-Public-RT-India"
  }
}

resource "aws_route_table_association" "terraform-public1-India" {
  provider       = aws.india
  subnet_id      = aws_subnet.subnet1-public-India.id
  route_table_id = aws_route_table.terraform-public-India.id
}
resource "aws_route_table_association" "terraform-public2-India" {
  provider       = aws.india
  subnet_id      = aws_subnet.subnet2-public-India.id
  route_table_id = aws_route_table.terraform-public-India.id
}
resource "aws_route_table_association" "terraform-public3-India" {
  provider       = aws.india
  subnet_id      = aws_subnet.subnet3-public-India.id
  route_table_id = aws_route_table.terraform-public-India.id
}

resource "aws_security_group" "allow_all-india" {
  provider    = aws.india
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.India-testvpc-1.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web-1-india" {
  provider                    = aws.india
  ami                         = "ami-08e5424edfe926b43"
  instance_type               = "t2.micro"
  key_name                    = "Mumkey"
  subnet_id                   = aws_subnet.subnet1-public-India.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all-india.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "Server-1"
    Env        = "Prod"
    Owner      = "Sree"
    CostCenter = "ABCD"
    Flavor     = "Ubuntu"
  }
  user_data = <<-EOF
  #!/bin/bash
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
    echo "<h1>Terraform testing </h1>" | sudo tee -a /var/www/html/indix.nginx-debian.html
EOF
}


