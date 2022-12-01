variable "name" {
    description = "Name"
    type = string
    default = ""
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
    default = ""
}

variable "cidr_block" {
    description = "CIDR range"
    type = string
    default = ""
}


variable "Public_subnet_CIDR_block" {
    description = "public subnet cidr range"
    type = list(string)
    default =  []
}

variable "Public_subnet_AZS" {
    description = "public subnet AZS"
    type = list(string)
    default = []
}

variable "Private_subnet_CIDR_block" {
    description = "private subnet cidr range"
    type = list(string)
    default = []
}

variable "Private_subnet_AZS" {
    description = "private subnet AZS"
    type = list(string)
    default = []
}

variable "Database_subnet_CIDR_block" {
    description = "Database subnet cidr range"
    type = list(string)
    default = []
}

variable "Database_subnet_AZS" {
    description = "Database subnet AZS"
    type = list(string)
    default = []
}
