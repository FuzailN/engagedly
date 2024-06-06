############################################################
      # Web & DB Private subnet
############################################################

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.engagedly_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"
}

############################################################
      # Bastion Public subnet
############################################################

resource "aws_subnet" "bastion_public_subnet" {
  vpc_id            = aws_vpc.engagedly_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}