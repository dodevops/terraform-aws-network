output "arn" {
  description = "ARN of the managed VPC"
  value       = aws_vpc.vpc.arn
}

output "id" {
  description = "ID of the managed VPC"
  value       = aws_vpc.vpc.id
}

output "private_subnet_ids" {
  description = "IDs of the managed private subnets"
  value       = { for suffix, value in aws_subnet.private_subnets : suffix => value.id }
}
output "private_subnet_cidrs" {
  description = "CIDR blocks of the managed private subnets"
  value       = { for suffix, value in aws_subnet.private_subnets : suffix => value.cidr_block }
}
output "public_subnet_ids" {
  description = "IDs of the managed public subnets"
  value       = { for suffix, value in aws_subnet.public_subnets : suffix => value.id }
}
output "public_subnet_cidrs" {
  description = "CIDR blocks of the managed public subnets"
  value       = { for suffix, value in aws_subnet.public_subnets : suffix => value.cidr_block }
}

output "security_group_id" {
  description = "The id of the managed security group"
  value       = aws_security_group.allow.id
}

output "vpce_endpoint_id_s3" {
  description = "ID of the VPC gateway endpoint"
  value       = aws_vpc_endpoint.gateway_endpoints[0].id
}
