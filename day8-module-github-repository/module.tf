module "devtest" {
    source = "github.com/CloudTechDevOps/terraform-10-30am/day-2-basic-ec2"
    ami ="ami-0aebec83a182ea7ea"
    key_name = "cherrykey"
    instance_type = "t2.micro"

  
}

