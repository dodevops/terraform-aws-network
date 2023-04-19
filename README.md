# TODO

## Introduction

This module manages TODO.

## Usage

Instantiate the module by calling it from Terraform like this:

```hcl
module "aws-eks" {
  source = "dodevops/TODO"
  version = "<version>"
  
  (...)
}
```

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## Development

Use [terraform-docs](https://terraform-docs.io/) to generate the API documentation by running

    terraform fmt .
    terraform-docs .
