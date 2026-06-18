resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc-cidir-block

  tags = {
    Name = format("%s-%s-my-vpc" ,var.project, var.env)
    env = var.env
  }
}


resource "aws_subnet" "pub-sub" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.pub-cidir-block

    map_public_ip_on_launch = true

    tags = {
      Name = format("%s %s-my-pub-sub",var.project,var.env)
      env: var.env
    }
}

resource "aws_subnet" "pri-sub" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = var.pri-cidir-block

  tags = {
    Name = format("%s %s-my-pri-sub",var.project,var.env)
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "${var.project}-igw"
    env = var.env
  }
}

resource "aws_default_route_table" "main-ft" {

    default_route_table_id = aws_vpc.my-vpc.default_route_table_id

    route{
        cidr_block = var.route-igw-cidr-block
        gateway_id = aws_internet_gateway.my-igw.id
    }
}