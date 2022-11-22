variable "name" {
    description = "Name"
    type = string
    default = "myoffice"
}

variable "access_key" {
    description = "Name"
    type = string
    default = ""
}

variable "secret_key" {
    description = "Name"
    type = string
    default = ""
}

variable "Environment" {
    description = "working ENV"
    type = string
    default = "test"
}

variable "cidr_block" {
    description = "CIDR range"
    type = string
    default = "10.10.0.0/16"
}


variable "Public_subnet_CIDR_block" {
    description = "public subnet cidr range"
    type = list(string)
    default =  ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "Public_subnet_AZS" {
    description = "public subnet AZS"
    type = list(string)
    default = ["us-east-1a", "us-east-1b"]
}

variable "Private_subnet_CIDR_block" {
    description = "private subnet cidr range"
    type = list(string)
    default = ["10.10.3.0/24", "10.10.4.0/24"]
}

variable "Private_subnet_AZS" {
    description = "private subnet AZS"
    type = list(string)
    default = ["us-east-1a", "us-east-1b"]
}

variable "Database_subnet_CIDR_block" {
    description = "Database subnet cidr range"
    type = list(string)
    default = ["10.10.5.0/24", "10.10.6.0/24"]
}

variable "Database_subnet_AZS" {
    description = "Database subnet AZS"
    type = list(string)
    default = ["us-east-1a", "us-east-1b"]
}
