resource "aws_vpc" "labos_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  #enable_dns_support = true
  #enable_classiclink = true
  #enable_classiclink_dns_support = true

  tags = {
    Name = "shai_vpc"
    "key" = "shai_vpc"
  }
}

resource "aws_internet_gateway" "labos_gw" {
  vpc_id = aws_vpc.labos_vpc.id

  tags = {
    Name = "shai_gateway"
    "key" = "shai_gateway"
  }
}

resource "aws_route_table" "labos_rt" {
  vpc_id = aws_vpc.labos_vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.labos_gw.id
  }
  
  tags = {
    Name = "shai_rout_table"
    "key" = "shai_rout_table"
  }
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id = aws_subnet.labos_subnet.id
  route_table_id = aws_route_table.labos_rt.id
}

resource "aws_subnet" "labos_subnet" {
  vpc_id = aws_vpc.labos_vpc.id
  cidr_block = var.subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone = "us-west-1a"

  tags = {
    Name = "shai_subnet"
    "key" = "shai_subnet"
  }
}

resource "aws_security_group" "labos_sg" {
  name_prefix = "shai_sg_"
  description = "Allow inbound traffic on port 80"
  vpc_id = aws_vpc.labos_vpc.id

  ingress {
    description  = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #ingress {
  #  description  = "SSH"
  #  from_port   = 22
  #  to_port     = 22
  #  protocol    = "tcp"
  #  cidr_blocks = ["0.0.0.0/0"]
  #}
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "key" = "shai_sg"
    Name = "shai_sg"
  }
}

resource "aws_instance" "labos_web_server" {
  ami = var.ami_id
  instance_type = var.instance_type
  #key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.labos_sg.id]
  subnet_id = aws_subnet.labos_subnet.id
  disable_api_termination = true
  associate_public_ip_address = true
  tags = {
    "key" = "shai_ec2_instance"
    Name = "shai_ec2_instance"
  }
    
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y docker.io
              sudo apt-get install -y docker-compose
              cd /home/ubuntu/
              sudo git clone https://github.com/shai-shabtai/labos-assignment.git
              cd labos-assignment/
              sudo docker-compose up -d
              EOF
}

resource "aws_eip" "labos_eip" {
  instance = aws_instance.labos_web_server.id
  vpc      = true
}

output "public_dns" {
  value = aws_eip.labos_eip.public_dns
}