resource "aws_vpc" "sowmya_vpc"{
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "projectk-vpc"
  }
}
#create public subnet
resource "aws_subnet" "sowmya-subnet"{
    vpc_id =aws_vpc.sowmya_vpc.id
    cidr_block = "10.0.0.0/24"
    tags = {
      Name="projectk-subnet"
    }

  }

#create internet gateway
resource "aws_internet_gateway" "sowmya-ig" {
  vpc_id = aws_vpc.sowmya_vpc.id
  tags={
    Name="ig"

  }
}

#create route table and edit routes
resource "aws_route_table" "sowmya-route"{
    vpc_id = aws_vpc.sowmya_vpc.id
    tags={
        Name="projectk-rt"
    }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sowmya-ig.id

  }
}
#create subnet associations
resource "aws_route_table_association" "sowmya-rt-associations" {
route_table_id = aws_route_table.sowmya-ig.id  
}

#create security groups
resource "aws_security_group" "sowmya-sg" {
    name = "allow all traffic"
    vpc_id=aws_vpc.sowmya_vpc.id
    tags={
        Name="sg-projectk"
    }
  ingress{
    description = "inbound traffic"
    from_port = 22
    to_port   = 22
    protocol  = "TCP"
    cidr_blocks = ["0.0.0.0.0/0"]
    
  }
  egress{
    description = "outbound traffic"
    from_port = 0
    to_port   = 0
    protocol  = "-1"  
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#create an ec2

resource "aws_instance" "ec2" {
ami ="ami-0aebec83a182ea7ea"
key_name = "cherrykey"
instance_type = "t2.micro"
subnet_id=aws_subnet.sowmya-subnet.id
vpc_security_group_ids = [aws_security_group.sowmya-sg.id]
associate_public_ip_address = true
 tags ={
    Name="projectk-ec2"
 }  

}