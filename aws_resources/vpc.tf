resource "aws_vpc" "ipfs" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "ipfs" {
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
  vpc_id            = aws_vpc.ipfs.id

  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "ipfs" {
  vpc_id = aws_vpc.ipfs.id
}

resource "aws_route_table" "ipfs" {
  vpc_id = aws_vpc.ipfs.id
}

resource "aws_route" "ipfs" {
  gateway_id             = aws_internet_gateway.ipfs.id
  route_table_id         = aws_route_table.ipfs.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "ipfs" {
  subnet_id      = aws_subnet.ipfs.id
  route_table_id = aws_route_table.ipfs.id
}

resource "aws_security_group" "ipfs" {
  vpc_id = aws_vpc.ipfs.id
  name   = "ipfs"
}

resource "aws_security_group_rule" "in_ssh" {
  security_group_id = aws_security_group.ipfs.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
}

resource "aws_security_group_rule" "in_ipfs_gateway" {
  security_group_id = aws_security_group.ipfs.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
}

resource "aws_security_group_rule" "in_ipfs_network" {
  security_group_id = aws_security_group.ipfs.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 4001
  to_port           = 4001
  protocol          = "tcp"
}

resource "aws_security_group_rule" "out_all" {
  security_group_id = aws_security_group.ipfs.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}
