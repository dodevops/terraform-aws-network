# terraform-aws-network

## Introduction

This module manages network resources in AWS.

## Usage

Instantiate the module by calling it from Terraform like this:

```hcl
module "aws-eks" {
  source = "dodevops/network/aws"
  version = "<version>"
  
  (...)
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- terraform (>=1.0.0)

- aws (>=3.33.0)

## Providers

The following providers are used by this module:

- aws (>=3.33.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [aws_internet_gateway.internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) (resource)
- [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) (resource)
- [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) (resource)
- [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) (resource)
- [aws_route_table_association.subnet_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) (resource)
- [aws_security_group.allow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) (resource)
- [aws_security_group_rule.private_allow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) (resource)
- [aws_security_group_rule.private_allow_postgres](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) (resource)
- [aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) (resource)
- [aws_subnet.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) (resource)
- [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) (resource)
- [aws_vpc_endpoint.gateway_endpoints](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) (resource)
- [aws_vpc_endpoint.interface_endpoints](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) (resource)

## Required Inputs

The following input variables are required:

### cidr\_block

Description: CIDR block for the VPC

Type: `string`

### private\_subnets

Description:   A map of private subnets, the key is used as a name suffix for the subnet. Each object has the following items:
  * cidr\_block: CIDR block used in subnet
  * availablity\_zone: availability zone to use
  * tags: A map of tags to set

Type:

```hcl
map(object({
    cidr_block : string,
    availability_zone : string,
    tags : map(string),
  }))
```

### project

Description: Project this configuration is for

Type: `string`

### public\_subnets

Description:   A list of public subnets, the key i used as a name suffi for the subnet. Each subnet has the following items:
  * cidr\_block: CIDR block used in subnet
  * availablity\_zone: availability zone to use
  * tags: A map of tags to set

Type:

```hcl
map(object({
    cidr_block : string,
    availability_zone : string,
    tags : map(string),
  }))
```

### region

Description: Name of the region

Type: `string`

### stage

Description: Name of the stage

Type: `string`

### suffix

Description: Suffix of the VPC name

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### tags

Description: Additional tags to set

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### arn

Description: ARN of the managed VPC

### id

Description: ID of the managed VPC

### private\_subnet\_cidrs

Description: CIDR blocks of the managed private subnets

### private\_subnet\_ids

Description: IDs of the managed private subnets

### public\_subnet\_cidrs

Description: CIDR blocks of the managed public subnets

### public\_subnet\_ids

Description: IDs of the managed public subnets

### security\_group\_id

Description: The id of the managed security group

### vpce\_endpoint\_id\_s3

Description: ID of the VPC gateway endpoint
<!-- END_TF_DOCS -->

## Development

Use [the terraform module tools](https://github.com/dodevops/terraform-module-tools) to check and generate the documentation by running

    docker run -v "$PWD":/terraform ghcr.io/dodevops/terraform-module-tools:latest
