variable "project" {
  type        = string
  description = "Project this configuration is for"
}

variable "stage" {
  type        = string
  description = "Name of the stage"
}

variable "region" {
  type        = string
  description = "Name of the region"
}

variable "tags" {
  type        = map(string)
  description = "Additional tags to set"
  default     = {}
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "suffix" {
  type        = string
  description = "Suffix of the VPC name"
}

variable "private_subnets" {
  type = map(object({
    cidr_block : string,
    availability_zone : string,
    tags : map(string),
  }))
  description = <<EOL
  A map of private subnets, the key is used as a name suffix for the subnet. Each object has the following items:
  * cidr_block: CIDR block used in subnet
  * availablity_zone: availability zone to use
  * tags: A map of tags to set
EOL
}

variable "public_subnets" {
  type = map(object({
    cidr_block : string,
    availability_zone : string,
    tags : map(string),
  }))
  description = <<EOL
  A list of public subnets, the key i used as a name suffi for the subnet. Each subnet has the following items:
  * cidr_block: CIDR block used in subnet
  * availablity_zone: availability zone to use
  * tags: A map of tags to set
EOL
}
