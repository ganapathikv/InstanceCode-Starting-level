resource "aws_vpc" "testvpc-1" {
  cidr_block           = "10.40.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name        = "Terraform-VPC"
    Owner       = "GANA"
    environment = "PROD"
  }
}
resource "aws_internet_gateway" "testvpc-IGW" {
  vpc_id = aws_vpc.testvpc-1.id
  tags = {
    Name = "Terraform-VPC-IGW"
  }
}