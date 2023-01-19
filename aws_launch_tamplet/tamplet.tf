# S3 Backup for .tfstate #
terraform {
  backend "s3" {
    bucket = "vaibhav-bucket02"
    key    = "launch_tamplet/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"
  config = {
    bucket = "vaibhav-bucket02"
    key    = "sg/terraform.tfstate"
    region = "us-east-1"
  }
}

# Launch Tamplet #
resource "aws_launch_template" "EC2LaunchTemplate" {
    name = var.name
    key_name = var.key_name
    network_interfaces {
        device_index = 0
        security_groups = [data.terraform_remote_state.sg.outputs.sg_id]
    }
    image_id = var.image_id
    instance_type = var.instance_type
    monitoring {
        enabled = true
    }
}