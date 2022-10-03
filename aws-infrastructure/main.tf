terraform {
  required_version = "~> 1.2"

  backend "s3" {
    bucket = "copacom"
    key    = "test1copacom/terraform.state"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "Networking" {
  source            = "./modules/Networking"
  availability_zone = "us-east-1a"
  environment       = "Development"
  allocation_id     = "eipalloc-e2583787"
}