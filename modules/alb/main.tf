resource "aws_lb" "web_alb" {
  name               = "web-alb-nt"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [var.alb_sg_id]

  tags = {
    Name = "web-alb-nt"
  }
}

resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg-nt"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "web-tg-nt"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "web_attachments" {
  count            = length(var.web_instance_ids)
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = var.web_instance_ids[count.index]
  port             = 80
}
