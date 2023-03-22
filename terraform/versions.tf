terraform {
  required_version = ">= 1"
  required_providers {
    aws = {
      version = ">= 3.74.0, < 4.0.0"
      source  = "hashicorp/aws"
    }
  }
}