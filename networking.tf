resource "aws_vpc" "vpc_Me" {
  cidr_block = "${var.vpcCIDRblock}"
  enable_dns_hostnames = true
  tags = {
    Name = "Main_vpc"
  }
}
resource "aws_route_table" "PrivateRouteTable" {
  vpc_id = "${aws_vpc.vpc_Me.id}"
  tags = {
    Name      = "Private Subnet Route Table"
    BuildWith = "terraform"
  }
}
# adding private route table to nat
resource "aws_route" "DefaultPrivateRoute" {
  route_table_id         = "${aws_route_table.PrivateRouteTable.id}"
  destination_cidr_block = "${var.destinationCIDRblock}"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}
# create external route to IGW
resource "aws_route" "DefaultPublicRoute" {
  route_table_id         = "${aws_route_table.PublicRouteTable.id}"
  destination_cidr_block = "${var.destinationCIDRblock}"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc_Me.id}"

  tags = {
    Name = "main"
  }
}
# adding an elastic IP
resource "aws_eip" "NatGatewayEIP" {
  vpc        = true
  depends_on = ["aws_internet_gateway.igw"]
}
# creating the NAT gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.NatGatewayEIP.id}"
  subnet_id     = "${aws_subnet.PublicSubnet1.id}"
  depends_on    = ["aws_internet_gateway.igw"]
}
# adding private subnet
resource "aws_subnet" "PrivateSubnet1" {
  vpc_id            = "${aws_vpc.vpc_Me.id}"
  cidr_block        = "${var.PrivateSubnet1CIDR}"
  availability_zone = "${element(var.availability_zones, 0)}"
  tags = {
    Name      = "Private_Subnet1"
  }
}
# associate subnet private subnet to private route table
resource "aws_route_table_association" "PrivateSubnet1RouteTableAssociation" {
  subnet_id      = "${aws_subnet.PrivateSubnet1.id}"
  route_table_id = "${aws_route_table.PrivateRouteTable.id}"
}
resource "aws_subnet" "PrivateSubnet2" {
  vpc_id            = "${aws_vpc.vpc_Me.id}"
  cidr_block        = "${var.PrivateSubnet2CIDR}"
  availability_zone = "${element(var.availability_zones, 1)}"
  tags = {
    Name      = "Private_Subnet2"
  }
}
resource "aws_route_table_association" "PrivateSubnet2RouteTableAssociation" {
  subnet_id      = "${aws_subnet.PrivateSubnet2.id}"
  route_table_id = "${aws_route_table.PrivateRouteTable.id}"
}
resource "aws_subnet" "PrivateSubnet3" {
  vpc_id            = "${aws_vpc.vpc_Me.id}"
  cidr_block        = "${var.PrivateSubnet3CIDR}"
  availability_zone = "${element(var.availability_zones, 0)}"
  tags = {
    Name      = "Private_Subnet3"
  }
}
resource "aws_route_table_association" "PrivateSubnet3RouteTableAssociation" {
  subnet_id      = "${aws_subnet.PrivateSubnet3.id}"
  route_table_id = "${aws_route_table.PrivateRouteTable.id}"
}
resource "aws_subnet" "PrivateSubnet4" {
  vpc_id            = "${aws_vpc.vpc_Me.id}"
  cidr_block        = "${var.PrivateSubnet4CIDR}"
  availability_zone = "${element(var.availability_zones, 1)}"
  tags = {
    Name      = "Private_Subnet4"
  }
}
resource "aws_route_table_association" "PrivateSubnet4RouteTableAssociation" {
  subnet_id      = "${aws_subnet.PrivateSubnet4.id}"
  route_table_id = "${aws_route_table.PrivateRouteTable.id}"
}
# associating subnet public subnets to public route table
resource "aws_route_table" "PublicRouteTable" {
  vpc_id = "${aws_vpc.vpc_Me.id}"
  tags = {
    Name      = "Public Subnet Route Table"
    BuildWith = "terraform"
  }
}
resource "aws_subnet" "PublicSubnet1" {
  vpc_id            = "${aws_vpc.vpc_Me.id}"
  cidr_block        = "${var.PublicSubnet1CIDR}"
  availability_zone = "${element(var.availability_zones, 0)}"
  tags = {
    Name      = "Public_Subnet1"
  }
}
resource "aws_route_table_association" "PublicSubnet1RouteTableAssociation" {
  subnet_id      = "${aws_subnet.PublicSubnet1.id}"
  route_table_id = "${aws_route_table.PublicRouteTable.id}"
}
resource "aws_subnet" "PublicSubnet2" {
  vpc_id            = "${aws_vpc.vpc_Me.id}"
  cidr_block        = "${var.PublicSubnet2CIDR}"
  availability_zone = "${element(var.availability_zones, 1)}"
  tags = {
    Name      = "Public_Subnet2"
  }
}
resource "aws_route_table_association" "PublicSubnet2RouteTableAssociation" {
  subnet_id      = "${aws_subnet.PublicSubnet2.id}"
  route_table_id = "${aws_route_table.PublicRouteTable.id}"
}