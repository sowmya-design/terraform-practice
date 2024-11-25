resource "aws_instance" "test" {
ami = "ami-0aebec83a182ea7ea"
instance_type = "t2.micro"
availability_zone = "ap-south-1a"
key_name = "aarvikey"
tags = {
    Name = "test"
  }


#lifecycle {
#    prevent_destroy = true
#}
lifecycle {
    create_before_destroy = true

}
}



