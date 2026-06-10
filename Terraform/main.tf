provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "my-security" {
    name = "my-security-group"

    ingress {
        from_port = 22   
        to_port = 22      
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80   
        to_port = 80      
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0                           # Allow all outbound traffic
        to_port = 0                             # Allow all outbound traffic
        protocol = "-1"                         # -1 means all protocols
        cidr_blocks = ["0.0.0.0/0"]             # Allow all outbound traffic
    }   

    tags = {
        Name = "${var.ami_id}-security-group"
    }

}

resource "aws_instance" "my_instance" {
    ami = var.ami_id
    instance_type = var.instace_type
    key_name = var.ssh_key_name
    security_groups = [aws_security_group.my-security.name]  # Associate the security group
    tags = {
        Name = "${var.ami_id}-instance"
    }

}


variable "my-vpc_id" {
    default = "vpc-0fe8216cd1aa1d37b"
}

variable "ami_id" {
    default = "ami-07a00cf47dbbc844c"
}

variable "instace_type"{
    default = "t3.micro"
}

variable "ssh_key_name" {
    default = "moo-key"
}