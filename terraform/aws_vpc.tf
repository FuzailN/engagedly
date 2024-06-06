############################################################
       # Creating VPC
#############################################################

resource "aws_vpc" "engagedly_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "engagedly-vpc"
  }
}

############################################################
       # Creating IGW for Jump Host
#############################################################

resource "aws_internet_gateway" "engagedly_igw" {
  vpc_id = aws_vpc.engagedly_vpc.id

  tags = {
    Name = "engagedly-igw"
  }
}