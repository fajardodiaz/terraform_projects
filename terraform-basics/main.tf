provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "automation_server" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = "AutomatizacionDevops"
  security_groups = ["automatizacion_devops__net"]
  tags            = var.tags
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = var.volume_size
    volume_type = "gp2"
  }
}