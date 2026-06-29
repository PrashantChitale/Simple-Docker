output "instance_public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "instance_arn" {
  value = aws_instance.my_instance.arn

}

output "instance_type" {
  value = aws_instance.my_instance.instance_type
}
