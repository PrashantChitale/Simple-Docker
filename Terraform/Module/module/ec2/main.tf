

resource "aws_instance" "my-instace" {
  ami = var.ami
  instance_type = var.instace-type
  key_name = var.key-name
  vpc_security_group_ids = [ aws_security_group.my-sg.id ]
  subnet_id = var.subnet-id

    tags = {
      Name = format("%s-%s-instace",var.project, var.env)
      env = var.env
    }
 
}


resource "aws_security_group" "my-sg" {
  vpc_id = var.vpc-id
  ingress {
    protocol = "TCP"
    to_port = 80
    from_port = 80
    cidr_blocks = var.cidir-block
  }

  ingress {
    protocol = "TCP"
    to_port = 22
    from_port = 22
    cidr_blocks = var.cidir-block
  }

  egress {
    protocol = "-1"
    to_port = 0
    from_port = 0
    cidr_blocks = var.cidir-block
  }
}