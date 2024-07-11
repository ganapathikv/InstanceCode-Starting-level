resource "aws_route_table" "terraform-public" {
  vpc_id = aws_vpc.testvpc-1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.testvpc-IGW.id
  }

  tags = {
    Name = "testvpc-1-Public-RT"
  }
}

resource "aws_route_table_association" "terraform-public1" {
  subnet_id      = aws_subnet.subnet1-public.id
  route_table_id = aws_route_table.terraform-public.id
}
resource "aws_route_table_association" "terraform-public2" {
  subnet_id      = aws_subnet.subnet2-public.id
  route_table_id = aws_route_table.terraform-public.id
}
resource "aws_route_table_association" "terraform-public3" {
  subnet_id      = aws_subnet.subnet3-public.id
  route_table_id = aws_route_table.terraform-public.id
}
