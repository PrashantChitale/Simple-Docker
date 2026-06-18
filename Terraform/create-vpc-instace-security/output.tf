output "public-ip" {
  value = aws_instance.my-instance.public_ip
}

output "vpc-id" {
  value = aws_vpc.my-vpc.id
}


output "private-subnet-id" {
  value = aws_subnet.my-pri-sub.id
}

output "public-subnet-id" {
  value = aws_subnet.my-pub-sub.id
}