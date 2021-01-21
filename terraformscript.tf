provider "aws" {
  region      = "us-east-1"
}

resource "aws_vpc" "devops_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "devvpc"
  }
}


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


