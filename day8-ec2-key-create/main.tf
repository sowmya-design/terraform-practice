resource "aws_key_pair" "name" {
    key_name = "testpublic"
    public_key = file("~/.ssh/id_rsa.pub") #here you need to define public key file path

  
}

resource "aws_instance" "dev" {
  ami ="ami-0aebec83a182ea7ea"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.name.key_name
  tags = {
    Name="yuvan"
  }
}

# resource "aws_key_pair" "name" {
#     key_name = "devops"
#     public_key = file("~/.ssh/id_ed25519.pub") #here you need to define public key file path

  
# }

# resource "aws_instance" "dev" {
#   ami                    = "ami-055e3d4f0bbeb5878"
#   instance_type          = "t2.micro"
#   key_name               = aws_key_pair.name.key_name
#   tags = {
#     Name="keerthi"
#   }
