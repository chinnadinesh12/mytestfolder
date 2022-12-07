# S3 Backup for .tfstate #
terraform {
  backend "s3" {
    bucket = "vaibhav-tfstate"
    key    = "sg/terraform.tfstate"
    region = "us-east-1"
  }
}

# Calling Remote state.tf Files #
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "vaibhav-tfstate"
    key    = "common/terraform.tfstate"
    region = "us-east-1"
  }
}

# Security Group #
resource "aws_security_group" "Office-sg" {
  vpc_id          = "${data.terraform_remote_state.vpc.outputs.vpc_id}"
  name        = "webserver"
  description = "Security Group for Web Servers"

  dynamic "ingress" {
    for_each = [22,80,443,]
    iterator = port

    content  {
      description = "Inbound Sec Permission"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
     for_each = [22,80,443,]
    content {
      description = "Outbound Sec Permission"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

}
