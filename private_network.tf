# Private network resources

resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  cidr_block        = each.value["cidr_block"]
  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.value["availability_zone"]
  tags = merge(
    each.value["tags"],
    {
      "Name" = "${lower(var.project)}${lower(var.stage)}netsubnet${each.key}"
    }
  )
  map_public_ip_on_launch = true
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet.id
  }
  tags = {
    Name = "${lower(var.project)}${lower(var.stage)}netroutetableprivate"
  }
}

resource "aws_route_table_association" "private" {
  for_each       = aws_subnet
  route_table_id = aws_route_table.private.id
  subnet_id      = each.value["id"]
}

resource "aws_security_group" "allow" {
  name   = "${lower(var.project)}${lower(var.stage)}netsgeksnodes"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "private_allow" {
  for_each          = var.private_subnets
  from_port         = 0
  protocol          = "all"
  security_group_id = aws_security_group.allow.id
  to_port           = 0
  type              = "ingress"
  cidr_blocks       = [each.value["cidr_block"]]
}

resource "aws_security_group_rule" "private_allow_postgres" {
  from_port         = 0
  protocol          = "all"
  security_group_id = aws_security_group.allow.id
  to_port           = 5432
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

locals {
  interface_endpoints = [
    "com.amazonaws.${var.region}.ec2",
    "com.amazonaws.${var.region}.ecr.api",
    "com.amazonaws.${var.region}.ecr.dkr",
    "com.amazonaws.${var.region}.logs",
    "com.amazonaws.${var.region}.sts",
    "com.amazonaws.${var.region}.elasticloadbalancing",
    "com.amazonaws.${var.region}.autoscaling",
    "com.amazonaws.${var.region}.rds"
  ]
  gateway_endpoints = [
    "com.amazonaws.${var.region}.s3",
  ]
}

resource "aws_vpc_endpoint" "interface_endpoints" {
  count              = length(local.interface_endpoints)
  service_name       = local.interface_endpoints[count.index]
  vpc_id             = aws_vpc.vpc.id
  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.allow.id]
  subnet_ids         = aws_subnet.private_subnets[*].id
}

resource "aws_vpc_endpoint" "gateway_endpoints" {
  count             = length(local.gateway_endpoints)
  service_name      = local.gateway_endpoints[count.index]
  vpc_id            = aws_vpc.vpc.id
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private.id]
}
