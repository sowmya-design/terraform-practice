variable "ami" {
    description = "this is the ami value"
    type = string
    default = "ami-0aebec83a182ea7ea"
    
  
}
variable "instance_type" {
    description = "this is the instancetype value"
    type = string
    default = "t2.micro"

  
}
variable "key_name" {
    description = "this is the keyvalue"
    type = string
    default = "cherrykey"
  
}
