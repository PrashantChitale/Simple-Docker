
resource "aws_lb_target_group" "TG-Home" {
  name = "TG-home"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = var.target_type

  health_check {
    path = "/"
    protocol = "HTTP"
  }

}


resource "aws_lb_target_group" "TG-Cloth" {
  name = "TG-Cloth"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = var.target_type

  health_check {
    path = "/cloth/"
    protocol = "HTTP"
  }
} 

resource "aws_lb_target_group" "TG-Laptop" {
  name = "TG-Laptop"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = var.target_type

  health_check {
    path = "/laptop/"
    protocol = "HTTP"
  }
}


resource "aws_lb" "my-lb" {
  name = "my-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [ aws_security_group.sg-lb.id ]
  subnets = var.subnets
}


resource "aws_security_group" "sg-lb" {

    vpc_id = var.vpc_id

    ingress {
        protocol = "TCP"
        from_port = 80
        to_port = 80
        cidr_blocks = [ "0.0.0.0/0" ]
    }

      ingress {
        protocol = "TCP"
        from_port = 22
        to_port = 22
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = [ "0.0.0.0/0" ]
    }

      tags = {
    "Name" = "${var.project}-security-grup"
  }
}


resource "aws_lb_listener" "lb-listener" {
   load_balancer_arn = aws_lb.my-lb.arn
   port = 80
   protocol = "HTTP"
   

   default_action {
     type = "forward"
     target_group_arn = aws_lb_target_group.TG-Home.arn
   }
}

resource "aws_lb_listener_rule" "lr-cloth" {
  listener_arn = aws_lb_listener.lb-listener.arn
  priority = 100

  action {
     type = "forward"
     target_group_arn = aws_lb_target_group.TG-Cloth.arn
  }
  
  condition {
    path_pattern {
      values = ["/cloth/*"]
    }
  }
}

resource "aws_lb_listener_rule" "lr-laptop" {
  listener_arn = aws_lb_listener.lb-listener.arn
  priority = 102

  action {
     type = "forward"
     target_group_arn = aws_lb_target_group.TG-Laptop.arn
  }
  
  condition {
    path_pattern {
      values = ["/laptop","/laptop/*"]
    }
  }
}
