# Configure the AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  access_key = "your_access_key"
  secret_key = "your_secret_key"
}



# 1. Create VPC
resource "aws_vpc" "vpc-demo" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "CI/CD-VPC"
  }
}

# 2. Create Internet Gateway 
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc-demo.id

  tags = {
    Name = "CI/CD-IG"
  }
}


# 3. Create Public Subnet one and two 
resource "aws_subnet" "Public-subnet1" {
  vpc_id            = aws_vpc.vpc-demo.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  map_public_ip_on_launch = true

  tags = {
    Name = "Public-subnet1"
  }
}

resource "aws_subnet" "Public-subnet2" {
  vpc_id            = aws_vpc.vpc-demo.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Public-subnet2"
  }
}

# 4. Create Public Route Table and associate with Public subnet one and two
resource "aws_route_table" "Public-route-table" {
  vpc_id = aws_vpc.vpc-demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  
  tags = {
    Name = "Public-Route-Table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.Public-subnet1.id
  route_table_id = aws_route_table.Public-route-table.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.Public-subnet2.id
  route_table_id = aws_route_table.Public-route-table.id
}
# 5. Create Security Group for Public Webserver one to allow port 80, 22 and all traffic
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.vpc-demo.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "custom tcp"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "custom tcp"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "custom tcp"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "CI/CD_Access"
  }
}

# 6. Create  Instance 0ne & Two
resource "aws_instance" "public_web1" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.medium"
  key_name = "your-key-pair"
  vpc_security_group_ids = [aws_security_group.allow_web.id]
  associate_public_ip_address = true
  subnet_id     = aws_subnet.Public-subnet1.id

ebs_block_device {
    device_name = "/dev/sdh"
    volume_type = "gp3"
    volume_size = 30
}

user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt upgrade -y
              EOF
       

  tags = {
    Name = "Jenkins-Instance"
  }
}

resource "aws_instance" "public_web2" {
  ami           = "ami-0a0e5d9c7acc336f1"
  instance_type = "t2.medium"
  key_name = "your-key-pair"
  vpc_security_group_ids = [aws_security_group.allow_web.id]
  associate_public_ip_address = true
  subnet_id     = aws_subnet.Public-subnet2.id

user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt upgrade -y
              EOF


  tags = {
    Name = "Docker-instance"
  }
}