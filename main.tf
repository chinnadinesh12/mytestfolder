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

