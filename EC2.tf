resource "aws_instance" "web-1" {
  ami                         = "ami-0261755bbcb8c4a84"
  instance_type               = "t2.micro"
  key_name                    = "N.Virginai_Key"
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "Server-1"
    Env        = "Prod"
    Owner      = "Sree"
    CostCenter = "ABCD"
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
