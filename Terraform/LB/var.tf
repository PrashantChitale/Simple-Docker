variable "image_id" {
  default = "ami-01a00762f46d584a1"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
    default = "moo-key"
}

variable "vpc_id" {
  default = "vpc-0fe8216cd1aa1d37b"
}

variable "project" {
   default = "Test"
}

variable "availability_zones" {
  default = ["ap-south-1a","ap-south-1b" ,"ap-south-1c"]
}


variable "target_type" {
  default = "instance"
}


variable "subnets" {
  default = ["subnet-04a5ee842bf9a39d0", "subnet-0564fdb6fa4706d0c" , "subnet-09e603f1f9d10f769"]
}