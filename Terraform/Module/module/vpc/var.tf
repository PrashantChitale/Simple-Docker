variable "vpc-cidir-block" {
  default = "10.0.0.0/16"
}

variable "project" {
  default = "JK"
}

variable "env" {
  default = "OnGoing"
}

variable "pri-cidir-block" {
  default = "10.0.0.0/20"
}


variable "pub-cidir-block" {
  default = "10.0.16.0/20"
}

variable "route-igw-cidr-block" {
  default = "0.0.0.0/0"
}