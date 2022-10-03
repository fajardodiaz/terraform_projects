# VPC
resource "aws_vpc" "npd_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "npd vpc"
    Environment = var.environment
  }
}


# Subnets
# Internet Gateway for public subnet
resource "aws_internet_gateway" "npd_intgat" {
  vpc_id = aws_vpc.npd_vpc.id

  tags = {
    Name        = "NPD Internet Gateway"
    Environment = var.environment
  }
}

# NAT Gateway
resource "aws_nat_gateway" "npd_natgat" {
  allocation_id = var.allocation_id
  subnet_id     = aws_subnet.npd_public_subnet.id

  tags = {
    Name = "NPD NAT Gateway"
    Environment = var.environment
  }

  depends_on = [aws_internet_gateway.npd_intgat]
}


# Public subnet
resource "aws_subnet" "npd_public_subnet" {
  vpc_id            = aws_vpc.npd_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = var.availability_zone
  tags = {
    Name        = "NPD Public Subnet"
    Environment = var.environment
  }
}


# Private subnet
resource "aws_subnet" "npd_private_subnet" {
  vpc_id            = aws_vpc.npd_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone
  tags = {
    Name        = "NPD Private Subnet"
    Environment = var.environment
  }
}

# Route table for Private Subnet
resource "aws_route_table" "npd_private_subnet_rt" {
  vpc_id = aws_vpc.npd_vpc.id

  tags = {
    Name        = "NPD Private Route Table"
    Environment = var.environment
  }
}

# Route table for Public Subnet
resource "aws_route_table" "npd_public_subnet_rt" {
  vpc_id = aws_vpc.npd_vpc.id

  tags = {
    Name        = "NPD Public Route Table"
    Environment = var.environment
  }
}

# Route for internet gateway
resource "aws_route" "npd_public_ig"{
    route_table_id = aws_route_table.npd_public_subnet_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.npd_intgat.id
} 

# Route for NAT gateway
resource "aws_route" "npd_private_ng"{
    route_table_id = aws_route_table.npd_private_subnet_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.npd_natgat.id
}

# Route table association for public and private subnet
resource "aws_route_table_association" "associate_public_subnet_rt" {
  subnet_id      = aws_subnet.npd_public_subnet.id
  route_table_id = aws_route_table.npd_public_subnet_rt.id
}

resource "aws_route_table_association" "associate_private_subnet_rt" {
  subnet_id      = aws_subnet.npd_private_subnet.id
  route_table_id = aws_route_table.npd_private_subnet_rt.id
}


# Default security group for the vpc
resource "aws_security_group" "npd_vpc_security_group"{
    name = "Security group for VPC"
    description = "Default SG to alllow traffic from the VPC"
    vpc_id = aws_vpc.npd_vpc.id
    depends_on = [aws_vpc.npd_vpc]

    ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }

  tags = {
    Name        = "NPD Security Group"
    Environment = var.environment
  }
}

