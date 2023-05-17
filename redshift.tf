
##############################################

# Create Redshift Subnet Group
resource "aws_redshift_subnet_group" "my_subnet_group" {
  name        = "my-subnet-group"
  description = "My Redshift Subnet Group"
  subnet_ids  = ["subnet-0c6a5530f3bb52ff9"]
}

# Create Security Group for Redshift
resource "aws_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "My Redshift Security Group"
  vpc_id      = "vpc-0df2ca49cea80e8f4"
  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Redshift Cluster
resource "aws_redshift_cluster" "my_cluster" {
  cluster_identifier        = "my-redshift-cluster"
  cluster_type              = "single-node"
  node_type                 = "dc2.large"
  master_username           = "admin"
  master_password           = "Vaibhav123"
  vpc_security_group_ids    = [aws_security_group.my_security_group.id]
  cluster_subnet_group_name = aws_redshift_subnet_group.my_subnet_group.name
}
