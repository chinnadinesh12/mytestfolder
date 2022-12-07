output "vpc_id" {
    value = "${aws_vpc.office_vpc.id}"
}

output "vpc_cidr_block" {
    value = aws_vpc.office_vpc.cidr_block
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

# output "Database-subnet" {
#     value = aws_subnet.Database-subnet[*].id
# }

output "aws_Public_rt" {
    value = aws_route_table.Public_rt.id
}

output "aws_Private_rt" {
    value = aws_route_table.Private_rt.id
}

#######################################################

# output "aws_Database-group" {
#   value = aws_db_subnet_group.Database-group.id
# }

# output "aws_nat_eip" {
#   value = aws_eip.nat.id
# }

# output "aws_ngw_id" {
#   value = aws_nat_gateway.ngw_id.id
# }




