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

variable "key_name" {
    type = string
    description = "key pair for logging into EC2"
    default = "winter_key"
}

