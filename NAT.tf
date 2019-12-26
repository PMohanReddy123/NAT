# Create EIP
resource "aws_eip" "nat" {
  vpc = true
  # count = "${length(aws_subnet.PublicSubnet.*.id)}"
  count = 1
}

# Create NAT gateway
resource "aws_nat_gateway" "nat" {
  # count = "${length(local.az_names)}"
  count         = 1
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.PublicSubnet.*.id, count.index)}"
  # subnet_id = "${cidrsubnet(var.vpc_cidr, 8, count.index)}"
  # depends_on    = ["aws_internet_gateway.igw"]
  tags = {
    Name = "NAT Gateway"
  }
}
resource "aws_route" "private_nat_route" {
  count = 1
  # count = "${length(local.az_names)}"
  # route_table_id         = "${(module.private_subnet.route_table_ids[count.index])}"
  route_table_id         = "${element(aws_route_table.pri_rt.*.id, count.index)}"
  nat_gateway_id         = "${element(aws_nat_gateway.nat.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
}

# resource "aws_route" "r" {
#   route_table_id            = "rtb-4fbb3ac4"
#   destination_cidr_block    = "10.0.1.0/22"
#   vpc_peering_connection_id = "pcx-45ff3dc1"
#   depends_on                = ["aws_route_table.testing"]
# }
