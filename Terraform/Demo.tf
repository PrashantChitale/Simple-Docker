provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my_instance" {
    ami = "ami-07a00cf47dbbc844c"
    instance_type = "t3.micro"
    key_name = "moo-key"
    tags = {
        Name = "MyInstance"
    }
}

