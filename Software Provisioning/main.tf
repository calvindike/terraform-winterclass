terraform {
    required_version = ">= 0.14"
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



