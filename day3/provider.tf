terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"  # Use any version >= 4.0 and < 5.0
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}
