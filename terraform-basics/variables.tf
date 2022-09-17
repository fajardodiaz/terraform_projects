variable "instance_type" {
  default = "t2.micro"
  type    = string
}

variable "ami_id" {
  default = "ami-08d4ac5b634553e16"
}

variable "tags" {
  default = {
    Name       = "Automation Server"
    Enviroment = "PreProd"
  }
}

variable "volume_size" {
  default = "20"
}