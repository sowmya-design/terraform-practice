resource "aws_instance" "dev" {
  ami ="ami-0aebec83a182ea7ea"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.name.key_name
  tags = {
    Name="yuvan-ec2"
  }
}