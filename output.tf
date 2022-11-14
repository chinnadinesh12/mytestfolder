output "vpc_id" {
    value = aws_vpc.office_vpc.id
}

output "IGW" {
   value = aws_internet_gateway.office_igw.id
}

output "Public-subnet" {
    value = aws_subnet.Public-subnet[*].id
}

output "Private-subnet" {
    value = aws_subnet.Private-subnet[*].id
}
