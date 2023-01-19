# S3 Backup for .tfstate #
terraform {
  backend "s3" {
    bucket = "vaibhav-bucket02"
    key    = "peering/terraform.tfstate"
    region = "us-east-1"
  }
}

# Calling Remote state.tf Files #
data "terraform_remote_state" "vpc_01" {
  backend = "s3"
  config = {
    bucket = "vaibhav-bucket02"
    key    = "common/terraform.tfstate"
    region = "us-east-1"
  }
}

# Calling Remote state.tf Files #
data "terraform_remote_state" "vpc_02" {
  backend = "s3"
  config = {
    bucket = "vaibhav-bucket02"
    key    = "env:/prod/common/terraform.tfstate"
    region = "us-east-1"
  }
}


resource "aws_vpc_peering_connection" "foo" {
  peer_owner_id = var.peer_owner_id
  peer_vpc_id   = "${data.terraform_remote_state.vpc_01.outputs.vpc_id}"
  vpc_id        = "${data.terraform_remote_state.vpc_02.outputs.vpc_id_02}"
  auto_accept   = true

  tags = {
    Name = "VPC Peering between foo and bar"
  }
}

resource "aws_vpc" "sender" {
  cidr_block = var.peer_owner_cidr
}

resource "aws_vpc" "accepter" {
  cidr_block = var.peer_accepter_cidr
}