# To pass the region at run time

# data "aws_region" "current" {}

# # Choosing the region
provider "aws" {
  region = "${var.region}"
}
