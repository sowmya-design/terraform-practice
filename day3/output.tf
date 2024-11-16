output "public_ip" {
  description = "Print public IP address of the instance"
  value = aws_instance.one.public_ip
}