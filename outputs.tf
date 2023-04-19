output "arn" {
  description = "ARN of the managed VPC"
  value       = aws_vpc.vpc.arn
}

output "id" {
  description = "ID of the managed VPC"
  value       = aws_vpc.vpc.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}
output "private_subnet_cidrs" {
  value = aws_subnet.private_subnets[*].cidr_block
}
output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}
output "public_subnet_cidrs" {
  value = aws_subnet.public_subnets[*].cidr_block
}

output "db_security_group_ids" {
  value = [aws_security_group.allow.id]
}

output "vpce_endpoint_id_s3" {
  value = aws_vpc_endpoint.gateway_endpoints[0].id
}
