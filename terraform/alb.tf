############################################################
      # Application LB
############################################################

resource "aws_lb" "app_lb" {
  name               = "engagedly-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [aws_subnet.bastion_public_subnet.id]
}

############################################################
      # Target Group
############################################################

resource "aws_lb_target_group" "app_tg" {
  name     = "engagedly-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.engagedly_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

############################################################
      # Listener
############################################################

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}