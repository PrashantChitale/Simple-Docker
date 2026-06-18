provider "aws" {
    region = "ap-south-1"
}


resource "aws_s3_bucket" "my-bucket" {
  bucket = "my-tf-test-bucket-712394252404"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
