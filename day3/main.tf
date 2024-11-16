resource "aws_instance" "first" {
    ami = var.ami
    instance_type = var.type
    key_name = var.key
    availability_zone = var.az  
}

