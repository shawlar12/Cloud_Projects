variable "access_key" {
  description = "AWS access key"
  default     = "AKIAWSRF6QLT3CZ3XFC3"
}
variable "secret_key" {
  description = "AWS secert access key"
  default     = "H27QthTZHVrXm5/rumXlmcVV4jsC/xW1IZO1s7Rt"
}
variable "key_name" {
  default     ="mysecr"
}
variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}
variable "ip_range" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
variable "vpcCIDRblock" {
  default = "17.0.0.0/16"
}
variable "destinationCIDRblock" {
  default = "0.0.0.0/0"
}
variable "InstanceType" {
  default = "t2.micro"
}
variable "internal" {
  description = "If true, ELB will be an internal ELB."
  default     = false
}
variable "PrivateSubnet1CIDR" {
  description = "CIDR for public subnet"
  default     = "17.0.3.0/24"
}
variable "PrivateSubnet2CIDR" {
  description = "CIDR for public subnet"
  default     = "17.0.4.0/24"
}
variable "PrivateSubnet3CIDR" {
  description = "CIDR for public subnet"
  default     = "17.0.5.0/24"
}
variable "PrivateSubnet4CIDR" {
  description = "CIDR for public subnet"
  default     = "17.0.6.0/24"
}
variable "PublicSubnet1CIDR" {
  description = "CIDR for public subnet"
  default     = "17.0.1.0/24"
}
variable "PublicSubnet2CIDR" {
  description = "CIDR for public subnet"
  default     = "17.0.2.0/24"
}
variable "Vpc_cidr" {
  description = "CIDR for VPC"
  default     = "17.0.0.0/16"
}
# creating private route table 
variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}
variable "imageID" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
  default     = "ami-0b898040803850657"
}
variable "ami_linux" {
  type = "map"
  default = {
    us-east-1 = "ami-0b898040803850657"
  }
}
variable "RDS_PASSWORD" {
default="MyRDSsimplePSSW"
}
variable "allocated_storage" {
default="10"
}
variable "engine" {
default="mysql"
}
variable "engine_version" {
default="5.7.22"
}
variable "instance_class" {
default="db.t2.micro"
}
variable "RDS_username" {
default="foo"
}