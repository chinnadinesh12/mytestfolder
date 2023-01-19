variable "ami" {
  description = "ami id"
  default     = "ami-0b5eea76982371e91"
}

variable "ec2_count" {
  description = "ec2 intance count"
  default     = "2"
}

variable "private_key" {
  description = "private key"
  default     = "newkey"
}

variable "availability_zone" {
  description = "Ec2 Availibility Zones"
  type        = list(string)
  default     = ["us-east-1a","us-east-1b"]
}

variable "subnet_id" {
  description = "Ec2 subnet_id"
  type        = list(string)
  default     = ["subnet-0a934b37f8dd356dd","subnet-057aa33505eba4d52"]
}

variable "instance_type" {
  description = "instance type"
  default     = "t2.micro"
}

variable "name" {
  description = "name of the ec2"
  default     = "test-ec2"
}


variable "Environment" {
  description = "env name"
  default     = "prod"
}


variable "volume_type" {
  description = "volume type"
  default     = "gp2"
}

variable "volume_size" {
  description = "volume size"
  default     = "8"
}

variable "delete_on_termination" {
  description = "delete on termination"
  default     = "true"
}
