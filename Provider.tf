provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = "<= 1.5.4" #Forcing which version of Terraform needs to be used
  required_providers {
    aws = {
      version = "<= 6.0.0" #Forcing which version of plugin needs to be used.
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "awsb49"
    key    = "myterraform.tfstate"
    region = "us-east-1"
  }
}