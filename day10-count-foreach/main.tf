# create instance 

resource "aws_instance" "example" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    # count = 2
    count = length(var.sandboxes )
    tags = {
    #   Name = "web"
    #   Name = "web-${count.index}"
    Name = var.sandboxes [count.index]
      
    }
}

variable sandboxes  {
  type =list(string)
  default = [ "dev","test" ]
}