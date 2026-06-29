resource "aws_instance" "my_instance" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [ var.security_group ]
  tags = {
    Name = format("%s-%s-instance", var.project, var.env)
  }

  user_data = <<-EOF
               #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y
               
                echo "Hello this is my page" > /var/www/html/index.html

                sudo systemctl start nginx
                sudo systemctl enable nginx

                EOF

}