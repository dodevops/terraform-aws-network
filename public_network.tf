# Public network resources

resource "aws_subnet" "public_subnets" {
  for_each          = var.public_subnets
  cidr_block        = each.value["cidr_block"]
  availability_zone = each.value["availability_zone"]
  vpc_id            = aws_vpc.vpc.id
  tags = merge(
    each.value["tags"],
    {
      "Name" = "${lower(var.project)}${lower(var.stage)}netsubnet${each.key}"
    }
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet.id
  }
  tags = {
    Name = "${lower(var.project)}${lower(var.stage)}netroutetable"
  }
}

resource "aws_route_table_association" "subnet_route_table" {
  for_each       = aws_subnet.public_subnets
  route_table_id = aws_route_table.public.id
  subnet_id      = each.value["id"]
}
