variable "availability_zone" {
  type        = string
  default     = "us-east-1a"
  description = "Availability zone"
}

variable "environment" {
  type        = string
  default     = "Development"
  description = "description"
}

variable "allocation_id" {
  type        = string
  description = "Elastic IP to associate NAT Gateway"
}



