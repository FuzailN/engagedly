############################################################
       # public-route-table
#############################################################

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.engagedly_vpc.id
}
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.engagedly_igw.id
  }

resource "aws_route_table_association" "public_assc" {
  subnet_id      = aws_subnet.bastion_public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

############################################################
       # private-route-table
#############################################################

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.engagedly_vpc.id
}

resource "aws_route_table_association" "private_webrt" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_dbrt" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}
