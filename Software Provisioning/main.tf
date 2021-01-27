terraform {
    required_version = ">= 0.14"
}

###### Subnets (Private and Public) ######

resource "aws_subnet" "devops-subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block
}

###### EC2 ######
resource "aws_instance" "example" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    key_name = var.key_name
    
    

    provisioner "file" {
        source = "script.sh"
        destination = "/tmp/script"
    }
    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/script.sh",
            "sudo /tmp/script.sh"
        ]
    }
}

###### EC2 ######

resource "aws_instance" "devops-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.devops-subnet.id

  tags = {
    Name = "${var.devops-instance_name} devops-instance"
  }
}

