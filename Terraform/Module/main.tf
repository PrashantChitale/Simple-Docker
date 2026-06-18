
provider "aws" {
  region = "ap-south-1"
}

module "my_vpc" {
    source = "./module/vpc"
}

module "my-inst" {
  source = "./module/ec2"
  ami = "ami-01a00762f46d584a1"
  instace-type = "t3.micro"
  key-name = "moo-key"
  project = "JK"
  env = "OnGoing"
  subnet-id = module.my_vpc.pub-subnet-id
  vpc-id = module.my_vpc.vpc-id

}