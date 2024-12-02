module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type         = var.type
  key_name               = "aarvikey"
  monitoring             = true
  subnet_id              = "subnet-07c46f798193db695"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

}