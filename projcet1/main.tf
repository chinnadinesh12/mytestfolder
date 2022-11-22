terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  alias  = "N.vergenia"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}


# Create Network-VPC
module "vpc" {
  providers = {
    aws = aws.N.vergenia
  }
  source = "../module/common"
  vpc_id = module.vpc.office_vpc
  name   = "${var.name}"
  Environment               = "${var.Environment}"
  cidr_block                = "${var.cidr_block}"
  Public_subnet_CIDR_block  = "${var.public_subnet_cidr_blocks}"
  Public_subnet_AZS         = "${var.Public_subnet_AZS}"
  Private_subnet_CIDR_block = "${var.Private_subnet_CIDR_block}"
  Private_subnet_AZS        = "${var.Private_subnet_AZS}"
  Database_subnet_CIDR_block = "${var.Database_subnet_CIDR_block}"
  Database_subnet_AZS        = "${var.Database_subnet_AZS}"
}
