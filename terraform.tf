# Required providers or terraform version, if any
terraform {
  required_version = ">=1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.33.0"
    }
  }
}
