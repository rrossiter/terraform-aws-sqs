terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
  }
}

provider "aws" {
  region  = "sa-east-1"
  profile ="default"

  default_tags {
    tags = {
      "created" = "terraform"
    }
  }

  # Para usar com o localstack.
  # endpoints {
  #   sqs      = "http://localhost:4566"
  # }
}
