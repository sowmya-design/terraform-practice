module "my-module" {
  source = "../day2-ec2-basic-code"
  ami = "ami-0aebec83a182ea7ea"
  instance_type = "t2.micro"
  key_name = "aarvikey"
}