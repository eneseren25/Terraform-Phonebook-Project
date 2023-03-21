terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.59.0" # Please check the version on website
    }
  } # Can add Github if you will use it,
}

provider "aws" {
  # Configuration options
  # Access key and Secret Key 
  # AWS CLI config can add use it too
  region = "us-east-1"
}

/* terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}  */


/* 
provider "github" {
  token = "xxxxxxxxxxxxxxxxxx"
} */