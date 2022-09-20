terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "app_server" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  security_groups = ["automatizacion_devops__net"]
  tags            = var.tags
  key_name        = var.key_name

  ebs_block_device {
    delete_on_termination = true
    device_name           = "/dev/sda1"
    volume_size           = var.disk_size
    volume_type           = "gp2"
  }

}
