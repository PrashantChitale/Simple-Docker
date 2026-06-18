provider "aws" {
  region = "ap-south-1"
}


resource "aws_security_group" "my-sg" {
  vpc_id = var.vpc_id

  ingress {
    protocol = "TCP"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    protocol = "TCP"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.project}-security-grup"
  }
}



resource "aws_launch_template" "LT-Home" {
  
    image_id= var.image_id
    
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [ aws_security_group.my-sg.id ]

         user_data = base64encode(<<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y 
                sudo systemctl start nginx
                sudo systemctl enable nginx 
                echo "Hello this is HOME page" > /var/www/html/index.html

                EOF
         )
    
}

resource "aws_launch_template" "LT-Cloth" {
  
    image_id= var.image_id
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [ aws_security_group.my-sg.id ]

         user_data = base64encode( <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y 
                mkdir -p /var/www/html/cloth
                sudo systemctl start nginx
                sudo systemctl enable nginx 
                echo "Hello this is Cloth page" > /var/www/html/cloth/index.html

                EOF
              )
}

resource "aws_launch_template" "LT-Laptop" {
  
    image_id= var.image_id
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [ aws_security_group.my-sg.id ]

         user_data = base64encode(  <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y 
                mkdir -p /var/www/html/laptop
                sudo systemctl start nginx
                sudo systemctl enable nginx   
                echo "Hello this is LAPTOP page" > /var/www/html/laptop/index.html

                EOF
         )    
}

resource "aws_autoscaling_group" "ASG-Home" {
        name ="ASG-Home"
        max_size = 2
        min_size = 1
        desired_capacity = 1
        availability_zones = var.availability_zones

        launch_template {
            id = aws_launch_template.LT-Home.id
            version = "$Latest"
        }
      
      target_group_arns = [ aws_lb_target_group.TG-Home.arn ]
       

}

resource "aws_autoscaling_group" "ASG-Cloth" {
        name ="ASG-Cloth"
        max_size = 2
        min_size = 1
        desired_capacity = 1
        availability_zones = var.availability_zones

        launch_template {
            id = aws_launch_template.LT-Cloth.id
            version = "$Latest"
        }

        target_group_arns = [ aws_lb_target_group.TG-Cloth.arn ]

}

resource "aws_autoscaling_group" "ASG-Laptop" {
        name ="ASG-Laptop"
        max_size = 2
        min_size = 1
        desired_capacity = 1
        availability_zones = var.availability_zones

        launch_template {
            id = aws_launch_template.LT-Laptop.id
            version = "$Latest"
        }

        target_group_arns = [ aws_lb_target_group.TG-Laptop.arn ]
}

resource "aws_autoscaling_policy" "ASGP-Home" {
        name = "ASGP-Home"
        autoscaling_group_name = aws_autoscaling_group.ASG-Home.name
        policy_type ="TargetTrackingScaling"


         target_tracking_configuration {
             predefined_metric_specification {
                  predefined_metric_type = "ASGAverageCPUUtilization"

                }

         target_value = 70.0
  }
}

resource "aws_autoscaling_policy" "ASGP-Cloth" {
        name = "ASGP-Cloth"
        autoscaling_group_name = aws_autoscaling_group.ASG-Cloth.name
        policy_type ="TargetTrackingScaling"


         target_tracking_configuration {
             predefined_metric_specification {
                  predefined_metric_type = "ASGAverageCPUUtilization"

                }

         target_value = 70.0
  }
}

resource "aws_autoscaling_policy" "ASGP-Laptop" {
        name = "ASGP-Laptop"
        autoscaling_group_name = aws_autoscaling_group.ASG-Laptop.name
        policy_type ="TargetTrackingScaling"


         target_tracking_configuration {
             predefined_metric_specification {
                  predefined_metric_type = "ASGAverageCPUUtilization"

                }

         target_value = 70.0
  }
}






