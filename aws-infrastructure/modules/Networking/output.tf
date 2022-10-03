output "vpc_id" {
  value = aws_vpc.npd_vpc.id
}

output "public_subnets_id" {
  value = ["${aws_subnet.npd_public_subnet.*.id}"]
}

output "private_subnets_id" {
  value = ["${aws_subnet.npd_private_subnet.*.id}"]
}

output "default_sg_id" {
  value = aws_security_group.npd_vpc_security_group.id
}

output "security_groups_ids" {
  value = ["${aws_security_group.npd_vpc_security_group.id}"]
}

output "public_route_table" {
  value = aws_route_table.npd_public_subnet_rt.id
}