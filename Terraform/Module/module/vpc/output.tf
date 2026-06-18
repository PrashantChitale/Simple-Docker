output "vpc-id" {
  value = aws_vpc.my-vpc.id
}

output "pub-subnet-id" {
  value = aws_subnet.pub-sub.id
}