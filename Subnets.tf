resource "aws_subnet" "subnet1-public" {
  vpc_id                  = aws_vpc.testvpc-1.id
  cidr_block              = "10.40.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "testvpc-Subnet-1"
  }
}

resource "aws_subnet" "subnet2-public" {
  vpc_id                  = aws_vpc.testvpc-1.id
  cidr_block              = "10.40.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "testvpc-Subnet-2"
  }
}

resource "aws_subnet" "subnet3-public" {
  vpc_id                  = aws_vpc.testvpc-1.id
  cidr_block              = "10.40.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"

  tags = {
    Name = "testvpc-Subnet-3"
  }

}
