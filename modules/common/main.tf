
# S3 Backup for .tfstate #
terraform {
  backend "s3" {
    bucket = "vaibhav-bucket02"
    key    = "common/terraform.tfstate"
    region = "us-east-1"
  }
}

# Create VPC #
resource "aws_vpc" "office_vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames  = "true"
  enable_network_address_usage_metrics = "true"

  tags = merge(
    {
      Name        = "${var.name}"
      Environment = "${var.Environment}"
    }
  )
}

# Create Internet Gateway #
resource "aws_internet_gateway" "office_igw" {
  vpc_id = aws_vpc.office_vpc.id

  tags = merge(
    {
      Name        = "${var.name}-IGW"
      Environment = "${var.Environment}"
    }
  )
}


# Create Public Subnet #
resource "aws_subnet" "Public-subnet" {
  vpc_id            = aws_vpc.office_vpc.id
  count             = length(var.Public_subnet_CIDR_block)
  cidr_block        = element(var.Public_subnet_CIDR_block, count.index)
  availability_zone = element(var.Public_subnet_AZS, count.index)

  tags = merge(
    {
      Tier        =  "Public"
      Name        = "${var.name}-Public-subnet"
      Environment = "${var.Environment}"
    }
  )
}

# # Create Private Subnet #
# resource "aws_subnet" "Private-subnet" {
#   vpc_id            = aws_vpc.office_vpc.id
#   count             = length(var.Private_subnet_CIDR_block)
#   cidr_block        = element(var.Private_subnet_CIDR_block, count.index)
#   availability_zone = element(var.Private_subnet_AZS, count.index)

#   tags = merge(
#     {
#       Tier        =  "Private"
#       Name        = "${var.name}-Private-subnet"
#       Environment = "${var.Environment}"
#     }
#   )
# }

#  #Create Database Subnet #
# resource "aws_subnet" "Database-subnet" {
#   vpc_id            = aws_vpc.office_vpc.id
#   count             = length(var.Database_subnet_CIDR_block)
#   cidr_block        = element(var.Database_subnet_CIDR_block, count.index)
#   availability_zone = element(var.Database_subnet_AZS, count.index)

#   tags = merge(
#     {
#       Name        = "${var.name}-Database-subnet"
#       Environment = "${var.Environment}"
#     }
#   )
# }


# # Create new routing table without internet access for instances
# data "aws_availability_zones" "available" {}

# locals {
#   network_count = length(data.aws_availability_zones.available.names)
# }

## Public Route Table ##

resource "aws_route_table" "Public_rt" {
  vpc_id = aws_vpc.office_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.office_igw.id
  }

  tags = merge(
    {
      Name        = "${var.name}-public-rt",
      Environment = "${var.Environment}"
    }
  )
}

## Private Route Table ##

# resource "aws_route_table" "Private_rt" {
#   vpc_id = aws_vpc.office_vpc.id
#   tags = merge(
#     {
#       Name        = "${var.name}-private-rt",
#       Environment = "${var.Environment}"
#     }
#   )
# }

#create Route Table and associate subnets [Public Subnets] #

resource "aws_route_table_association" "public_rt" {
  count          = length(var.Public_subnet_CIDR_block)
  subnet_id      = aws_subnet.Public-subnet[count.index].id
  route_table_id = aws_route_table.Public_rt.id
}


# #create Route Table and associate subnets [Private Subnets] #

# resource "aws_route_table_association" "private_rt" {
#   count          = length(var.Private_subnet_CIDR_block)
#   subnet_id      = aws_subnet.Private-subnet[count.index].id
#   route_table_id = aws_route_table.Private_rt.id
# }

# till hear working ##
#################################################################################################

# resource "aws_db_subnet_group" "Database-group" {
#   name       = "main"
#   subnet_ids = aws_subnet.Database-subnet.*.id

#   tags = merge(
#     {
#       Name        = "${var.name}-Database-group",
#       Environment = "${var.Environment}"
#     }
#   )
# }

# #Create an NAT gateway to give our private subnet access the outside world 
# resource "aws_eip" "nat" {
#   vpc = true
# }
# resource "aws_nat_gateway" "ngw_id" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.Public-subnet[0].id

#   tags = merge(
#     {
#       Name        = "${var.name}-NATGW",
#       Environment = "${var.Environment}"
#     }
#   )
#   depends_on = [aws_internet_gateway.office_igw]
# }

# resource "aws_route" "private" {
#   route_table_id         = aws_route_table.Private_rt.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.ngw_id.id
#   depends_on             = [aws_route_table_association.private_rt]
# }
# ##############################
