variable "AMIS" {
    type = map
    description = "AMI for deploying EC2 instance"
    default {
        us-east-1 = "ami-0ae74ae9c43584639"
        us-west-2 = "ami-0fd6ea4f6e12ac1dc"
        eu-west-1 = "ami-0cba7e5b160fc5311"
    }
}

variable "AWS_REGION" {
    type = string
    description = "Region where instance is to be deployed"
    default = "us-east-1"
}

variable "vpc_id" {
    type = string
    description = "VPC id"
}

variable "cidr_block" {
    type = string
    description = "Subnet cidr block"
}

variable "key_name" {
    type = string
    description = "key pair for logging into EC2"
    default = "winter_key"
}

variable "instance_name" {
    type = string
    description = "Name of EC2 instance"
}

variable "instance_type" {
    type = string
    description = "Type of EC2 eg. t2.micro"
}


