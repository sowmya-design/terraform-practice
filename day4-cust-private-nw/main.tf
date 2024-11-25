#vpc creation
resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    tags ={
        Name = "aarvi-vpc"
         }
}
#subnets creation
resource "aws_subnet" "pub-sub" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name="public subnet"
  }
}
resource "aws_subnet" "pri-sub" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.1.0/24"
    tags={
        Name="private subnet"
    }
}
#internet gateway
resource "aws_internet_gateway" "ig" {
    vpc_id=aws_vpc.vpc.id
    tags={
        Name="internet-gateway"
    }
}
#elastic ip creation
resource "aws_eip" "eip" {

}
#nat gateway
resource "aws_nat_gateway" "nat" {
    subnet_id=aws_subnet.pub-sub.id
    allocation_id = aws_eip.eip.id
    tags={
        Name="NAT"
    }
}
#PUBLIC ROUTE TABLE 
resource "aws_route_table" "pub-route" { 
  vpc_id = aws_vpc.vpc.id 
  tags = { 
    Name="Public Route" 
  } 
  route { 
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.ig.id 
  } 
} 
#PRIVATE ROUTE TABLE 
resource "aws_route_table" "pvt-route" { 
  vpc_id = aws_vpc.vpc.id 
  tags = { 
    Name="Private route" 
  } 
  route { 
    cidr_block = "0.0.0.0/0" 
    nat_gateway_id = aws_nat_gateway.nat.id 
  } 
} 
#PUBLIC SUBNET ASSOCIATION 
resource "aws_route_table_association" "pub-rt-as" { 
  route_table_id = aws_route_table.pub-route.id 
  subnet_id = aws_subnet.pub-sub.id 
} 
#PRIVATE SUBNET ASSOCIATION 
resource "aws_route_table_association" "pvt-rt-as" { 
  subnet_id = aws_subnet.pri-sub.id 
  route_table_id = aws_route_table.pvt-route.id 
} 
#SECURITY GROUP 
resource "aws_security_group" "sg" { 
name = "security group description" 
vpc_id = aws_vpc.vpc.id 
tags = { 
  Name="CUSTOM-NW-SG" 
} 
ingress { 
  description = "terrafrom created sg" 
  from_port = 22 
  to_port = 22 
  protocol = "TCP" 
  cidr_blocks = ["0.0.0.0/0"] 
} 
egress { 
  from_port = 0 
  to_port = 0 
  protocol = "-1" 
  cidr_blocks = ["0.0.0.0/0"] 
} 
} 
#PUBLIC SERVER WITH IP 
resource "aws_instance" "server-pub" { 
  subnet_id = aws_subnet.pub-sub.id 
  vpc_security_group_ids =[aws_security_group.sg.id]
  ami = "ami-0aebec83a182ea7ea" 
  instance_type = "t3.medium" 
  key_name = "aarvikey" 
  associate_public_ip_address = true 
  tags = { 
    Name="Public-Server-Using-Terrafrom" 
  } 
} 
#PRIVATE SERVER WITH NAT 
resource "aws_instance" "pvt-server" { 
  ami = "ami-0aebec83a182ea7ea" 
  instance_type = "t3.medium" 
  key_name = "aarvikey" 
  tags = { 
    Name="Private-Server-Using-Terrafrom" 
  } 
  subnet_id = aws_subnet.pri-sub.id 
  vpc_security_group_ids =[aws_security_group.sg.id]
}

