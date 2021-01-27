###### Provider ######

provider "aws" {
    region = var.AWS_REGION
}

###### VPC ######

resource "aws_vpc" "devops_vpc" {
    cidr_block = "10.0.1.0/16"
    instance_tenancy = "default"

    tags = {
        Name = "DevOps VPC"
    }
}

module "NginxUbuntuServer" {
    source = "../Software\nprovisioning"
    vpc_id = aws_vpc.devops_vpc.id
    cidr_block = "10.0.1.0/16"
    instance_name = "nginx1"
    ami = var.AMIS
    instance_type = "t2.micro"
    key_name = "winter_key"
}
