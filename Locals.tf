locals {
  az_names    = "${data.aws_availability_zones.azs.names}"
  pub_sub_ids = "${aws_subnet.PublicSubnet.*.id}"
  # pri_sub_ids = "${aws_subnet.PrivateSubnet.*.id}"
}
