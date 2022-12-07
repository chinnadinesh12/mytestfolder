#terraform {
#  required_providers {
#    aws = {
#      source  = "hashicorp/aws"
#      version = "~> 4.0"
#    }
#  }
#}
# S3 Backup for .tfstate #
terraform {
  backend "s3" {
    bucket = "vaibhav-tfstate"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}


# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  alias  = "use1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}
# Create Network-VPC
module "vpc" {
  source    = "../modules/common"
#  providers = {
#    aws = aws.use1
#  }

  
  name   = var.name
  Environment               = "${var.Environment}"
  cidr_block                = "${var.cidr_block}"
  Public_subnet_CIDR_block  = "${var.Public_subnet_CIDR_block}"
  Public_subnet_AZS         = "${var.Public_subnet_AZS}"
  Private_subnet_CIDR_block = "${var.Private_subnet_CIDR_block}"
  Private_subnet_AZS        = "${var.Private_subnet_AZS}"
  Database_subnet_CIDR_block = "${var.Database_subnet_CIDR_block}"
  Database_subnet_AZS        = "${var.Database_subnet_AZS}"

#  tags = {
#    Terraform = "true"
#  }
}
