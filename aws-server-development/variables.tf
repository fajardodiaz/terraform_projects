variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Instance Region"
}

variable "instance_ami" {
  type        = string
  default     = "ami-08d4ac5b634553e16"
  description = "OS for the server"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The instance type. Ex: t2.micro, c5.xlarge"
}

variable "disk_size" {
  type        = string
  default     = "15"
  description = "Volume size for the instance"
}

variable "key_name" {
  type        = string
  default     = "AutomatizacionDevops"
  description = "SSH Key"
}


variable "tags" {
  type = map(any)
  default = {
    Name        = "DevelopmentServer"
    Environment = "Development"
  }
  description = "Tags for the instance"
}