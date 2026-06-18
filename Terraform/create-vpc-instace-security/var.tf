variable "ami_id" {
    default = "ami-07a00cf47dbbc844c"
}

variable "vpc_cidr_block" {
    default = "10.0.0.0/16"
}


variable "pri-subnet_cidr_block"{
    default = "10.0.0.0/20"
}

variable "pub-subnet_cidr_block" {
    default = "10.0.16.0/20"
}

variable "vpc-route-igw-cidr_block" {
    default = "0.0.0.0/0"
}

variable "instace_type" {
    default = "t3.micro"
}

variable "ssh_key_name" {
    default = "moo-key"
}