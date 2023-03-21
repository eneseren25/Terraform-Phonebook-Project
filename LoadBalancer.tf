resource "aws_alb" "alb" {
  name               = "${var.mytag}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sec-group.id]
  subnets            = [for subnet in data.aws_subnet.public : subnet.id]
  /* subnets            = [aws_subnet.public-1a.vpc_id, aws_subnet.public-1b.vpc_id] */
  ip_address_type    = "ipv4"
  /* subnets = [for subnet in aws_subnet.public : subnet.id] */ # Can be use 

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "targett" {
  name        = "${var.mytag}-target"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"
  health_check {
    healthy_threshold   = 3
    interval            = 20
    unhealthy_threshold = 3
    timeout             = 5
    path                = "/"
    protocol            = "HTTP"
  }
}

resource "aws_lb_listener" "name" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.targett.arn
  }
}

