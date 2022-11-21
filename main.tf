# Create VPC #
resource "aws_vpc" "office_vpc" {
  cidr_block = "${var.cidr_block}"
  instance_tenancy = "default"

    tags = merge (
        {
    Name = "${var.name}"
    Environment = "${var.Environment}"
    }
    )
}

# Create Internet Gateway #
resource "aws_internet_gateway" "office_igw" {
  vpc_id = aws_vpc.office_vpc.id

    tags = merge (
        {
    Name = "${var.name}-IGW"
    Environment = "${var.Environment}"
    }
    )
}


# Create Public Subnet #
resource "aws_subnet" "Public-subnet" {
  vpc_id = aws_vpc.office_vpc.id
  count = "${length(var.Public_subnet_CIDR_block)}"
  cidr_block = "${element(var.Public_subnet_CIDR_block, count.index)}"
  availability_zone = "${element(var.Public_subnet_AZS, count.index)}"

    tags = merge (
        {
    Name = "${var.name}-Public-subnet"
    Environment = "${var.Environment}"
    }
    )
}

# Create Private Subnet #
resource "aws_subnet" "Private-subnet" {
  vpc_id = aws_vpc.office_vpc.id
  count = "${length(var.Private_subnet_CIDR_block)}"
  cidr_block = "${element(var.Private_subnet_CIDR_block, count.index)}"
  availability_zone = "${element(var.Private_subnet_AZS, count.index)}"

    tags = merge (
        {
    Name = "${var.name}-Private-subnet"
    Environment = "${var.Environment}"
    }
    )
}

# Create Database Subnet #
resource "aws_subnet" "Database-subnet" {
  vpc_id = aws_vpc.office_vpc.id
  count = "${length(var.Database_subnet_CIDR_block)}"
  cidr_block = "${element(var.Database_subnet_CIDR_block, count.index)}"
  availability_zone = "${element(var.Database_subnet_AZS, count.index)}"

    tags = merge (
        {
    Name = "${var.name}-Database-subnet"
    Environment = "${var.Environment}"
    }
    )
}

# Create new routing table without internet access for instances
data "aws_availability_zones" "available" {}

locals {
  network_count = "${length(data.aws_availability_zones.available.names)}"
}

## Public Route Table ##

resource "aws_route_table" "Public_rt" {
  vpc_id = aws_vpc.office_vpc.id
  tags = merge(
    {
      Name        = "${var.name}-public-rt",
      Environment = "${var.Environment}"
    }
  )
}

## Private Route Table ##

resource "aws_route_table" "Private_rt" {
  vpc_id = aws_vpc.office_vpc.id
  tags = merge(
    {
      Name        = "${var.name}-public-rt",
      Environment = "${var.Environment}"
    }
  )
}

# create Route Table and associate subnets [Public Subnets] #

resource "aws_route_table_association" "public_rt" {
  count          = "${length(var.Public_subnet_CIDR_block)}"
  subnet_id      = aws_subnet.Public-subnet[count.index].id   
  route_table_id = aws_route_table.Public_rt.id
}


# create Route Table and associate subnets [Private Subnets] #

resource "aws_route_table_association" "private_rt" {
  count          = "${length(var.Private_subnet_CIDR_block)}"
  subnet_id      = aws_subnet.Private-subnet[count.index].id 
  route_table_id = aws_route_table.Private_rt.id
}
