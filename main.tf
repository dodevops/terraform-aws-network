# AWS network resources

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  tags = merge(
    var.tags,
    {
      Name = "${lower(var.project)}${lower(var.stage)}netvpc${var.suffix}"
    }
  )
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${lower(var.project)}${lower(var.stage)}netigw"
  }
}
