variable "region" {
  # description = "Choose region"
  # type        = "string"
  default = "ap-south-1"
}
variable "vpc_cidr" {
  # description = "Choose CIDR for VPC"
  # type        = "string"
  default = "10.0.0.0/16"
}
variable "vpc_name" {
  default = "VPC"
}
variable "vpc_tenancy" {
  default = "default"
}
variable "PublicSub_count" {
  default = "2"
}

variable "PublicSubnet_Cidr" {
  type    = "list"
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "publicsubnetname" {
  type    = "list"
  default = ["pb1", "pb2"]
}
variable "publicaznames" {
  type    = "list"
  default = ["ap-south-1b", "ap-south-1c"]
}
variable "PrivateSub_count" {
  default = "2"
}
variable "PrivateSubnet_Cidr" {
  type    = "list"
  default = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "Privatesubnetname" {
  type    = "list"
  default = ["pr1", "pr1"]
}
variable "privateaznames" {
  type    = "list"
  default = ["ap-south-1a", "ap-south-1b"]
}
