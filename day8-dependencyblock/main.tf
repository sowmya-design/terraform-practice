 #creating s3 bucket and dynamo DB for state backend storgae and applying the lock mechanisam for statefile

provider "aws" { 
    region = "ap-south-1"
}



resource "aws_s3_bucket" "example" {
  bucket = "aarviiii"
  depends_on = [ aws_instance.dev ]
}



resource "aws_instance" "dev" {
    ami ="ami-0aebec83a182ea7ea"
    instance_type = "t2.micro"
    
}



 