variable "ami" {
  default = ""
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  default = "moo-key"
}

variable "security_group" {
    default = ""
}

variable "project" {
  default = "JK"
}

variable "env" {
  default = "OnGoing"
}