variable "name" {
  description = "Tamplet name"
  type = string
  default = "test-tamplet"
}

variable "key_name" {
  description = "instance key pair"
  type = string
  default = "newkey"
}

variable "image_id" {
  description = "ami id"
  type = string
  default = "ami-06878d265978313ca"
}

variable "instance_type" {
  description = "instace type"
  type = string
  default = "t2.micro"
}
