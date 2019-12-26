# To Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.vpc_tenancy}"
  # enable_dns_hostnames = "${var.enable_dns_hostnames}"
  tags = {
    Name = "${var.vpc_name}"
  }
}
# To Create Public subnet
resource "aws_subnet" "PublicSubnet" {
  # count = "${length(local.az_names)}
  count  = "${var.PublicSub_count}"
  vpc_id = "${aws_vpc.my_vpc.id}"
  # cidr_block              = "${element(var.PublicSubnet_Cidr, count.index)}"
  cidr_block              = "${element(var.PublicSubnet_Cidr, count.index)}"
  map_public_ip_on_launch = true
  availability_zone       = "${element(var.publicaznames, count.index)}"
  # availability_zone       = "${local.az_names[count.index]}"
  tags = {
    # Name = "PublicSubnet-${count.index + 1
    Name = "${element(var.publicsubnetname, count.index)}"
  }
}
# Create Internet Gatewway for Public subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  tags = {
    Name = "IGW"
  }
}

# Create Route Table and attach IGW
resource "aws_route_table" "pub_rt" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "PublicRT"
  }
}

# Public subnet and route table association

resource "aws_route_table_association" "pub_rt_association" {
  count = "${length(local.az_names)}"
  # subnet_id      = "${local.pub_sub_ids[count.index]}"
  subnet_id      = "${element(aws_subnet.PublicSubnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.pub_rt.id}"
}

resource "aws_subnet" "PrivateSubnet" {
  # count  = "${length(local.az_names)}"
  count  = "${var.PrivateSub_count}"
  vpc_id = "${aws_vpc.my_vpc.id}"
  # cidr_block = "${element(var.PrivateSubnet_Cidr, count.index)}"
  # cidr_block              = "${cidrsubnet(var.vpc_cidr, 8, count.index + length(local.az_names))}"
  cidr_block = "${element(var.PrivateSubnet_Cidr, count.index)}"
  # cidr_block              = "${var.PrivateSubnet_Cidr}"
  map_public_ip_on_launch = false
  # availability_zone       = "${local.az_names[count.index]}"
  availability_zone = "${element(var.privateaznames, count.index)}"
  tags = {
    # Name = "PublicSubnet-${count.index + 1
    Name = "${element(var.Privatesubnetname, count.index)}"
  }
}
# Create Route Table
resource "aws_route_table" "pri_rt" {
  count = 1
  # count  = "${length(local.az_names)}"
  vpc_id = "${aws_vpc.my_vpc.id}"
  # route {
  #   cidr_block     = "0.0.0.0/0"
  #   nat_gateway_id = "${aws_nat_gateway.nat.*.id}"
  # }
  tags = {
    Name = "PrivateRT-${count.index + 1}"
  }
}

# Private subnet and route table association

resource "aws_route_table_association" "pri_rt_association" {
  count = "${length(local.az_names)}"
  # subnet_id      = "${local.pri_sub_ids[count.index]}"
  subnet_id      = "${element(aws_subnet.PrivateSubnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.pri_rt.*.id, count.index)}"
}
