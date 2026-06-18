provider "aws" {
  region = "ap-south-1"
}


resource "aws_security_group" "my_security_group" {
    name = "my-security-group"
    vpc_id = aws_vpc.my-vpc.id   #it is use to associate security group with the vpc 
                                #because security group is a vpc level resource and it must be associated with a vpc 

    ingress {
        protocol = "TCP"
        from_port = 22
        to_port =22
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        protocol = "TCP"
        from_port =80
        to_port =80
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress { 
        protocol = "-1"
        from_port =0
        to_port =0
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags ={
        Name = "${var.ami_id}-security-group"
    }
}


resource "aws_vpc" "my-vpc"{
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "${var.ami_id}-vpc"
    }
}

resource "aws_subnet" "my-pri-sub" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.pri-subnet_cidr_block

    tags = {
        Name = "${var.ami_id}-private-subnet"
    }
}

resource "aws_subnet" "my-pub-sub" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.pub-subnet_cidr_block

    map_public_ip_on_launch = true     #it is use to assign public ip to the instance when it launch in this subnet

    tags = {
        Name = "${var.ami_id}-public-subnet"
    }
}

resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "${var.ami_id}-internet-gateway"   
    }
}

resource "aws_default_route_table" "main-route-table" {

    default_route_table_id = aws_vpc.my-vpc.default_route_table_id

    route {
        cidr_block = var.vpc-route-igw-cidr_block
         gateway_id = aws_internet_gateway.my-igw.id
    }

    tags = {
        Name = "${var.ami_id}-main-route-table"
    }
}


resource "aws_instance" "my-instance" {
  
    ami = var.ami_id 
    instance_type = var.instace_type
    key_name = var.ssh_key_name
    vpc_security_group_ids = [aws_security_group.my_security_group.id]   #it is use to associate security group with the instance
    subnet_id = aws_subnet.my-pub-sub.id
    tags = {
        Name = "${var.ami_id}-instance"
    }

    user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y 
                sudo systemctl start nginx
                sudo systemctl enable nginx 
                echo "Hello this is my page" > /var/www/html/index.html

                EOF

}

