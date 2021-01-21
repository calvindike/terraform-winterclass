###### Provider ######

provider "aws" {
  region      = "us-east-1"
}


###### VPC ######

resource "aws_vpc" "devops_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "devvpc"
  }
}

###### Subnets (Private and Public) ######

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.devops_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "devops_privateSubnet"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.devops_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "devops_publicSubnet"
  }
}

###### Gateway ######

resource "aws_internet_gateway" "devops-GW" {
  vpc_id = aws_vpc.devops_vpc.id

  tags = {
    Name = "devops_gateway"
  }
}

###### Route table ######

resource "aws_route_table" "devops-R" {
  vpc_id = aws_vpc.devops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops-GW.id
  }

  tags = {
    Name = "devops_route"
  }
}

###### Route table association ######

resource "aws_route_table_association" "association_private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.devops-R.id
}

resource "aws_route_table_association" "association_public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.devops-R.id
}

###### Security Group ######

resource "aws_security_group" "devops_SG" {
  name        = "devops_SG"
  description = "Allow TLS inbound traffic 22"
  vpc_id      = aws_vpc.devops_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
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
    Name = "devops_SG"
  }
}














