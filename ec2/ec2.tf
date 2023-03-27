# S3 Backup for .tfstate #
terraform {
  backend "s3" {
    bucket = "vaibhav-bucket02"
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"
  }
}

# Calling Remote state.tf Files #
data "terraform_remote_state" "sg" {
  backend = "s3"
  config = {
    bucket = "vaibhav-bucket02"
    key    = "sg/terraform.tfstate"
    region = "us-east-1"
  }
}

# Calling Remote state.tf Files #
data "terraform_remote_state" "vpc_subnet_ids" {
  backend = "s3"
  config = {
    bucket = "vaibhav-bucket02"
    key    = "common/terraform.tfstate"
    region = "us-east-1"
  }
}


resource "aws_instance" "EC2Instance" {
    ami = var.ami
    count = var.ec2_count
    instance_type = var.instance_type
    key_name = var.private_key
    availability_zone = element(var.availability_zone, count.index)
    tenancy = "default"
    subnet_id = element(var.subnet_id, count.index) # element(data.terraform_remote_state.vpc_subnet_ids.outputs.subnet_ids, count.index)
    ebs_optimized = false
    vpc_security_group_ids = [data.terraform_remote_state.sg.outputs.sg_id]
    source_dest_check = true
    root_block_device {
        volume_size = var.volume_size
        volume_type = var.volume_type
        delete_on_termination = var.delete_on_termination
    }
    tags = {
      name = var.name
    }
}
