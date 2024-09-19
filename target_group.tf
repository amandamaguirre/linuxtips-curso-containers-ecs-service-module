resource "aws_alb_target_group" "main" {
  name = format("%s-%s", var.cluster_name, var.service_name)

  port   = var.service_port
  vpc_id = var.vpc_id

  protocol    = "HTTP"
  target_type = "ip"

  health_check {
    healthy_threshold   = lookup(var.service_health_check, "healthy_threshold", "3")
    unhealthy_threshold = lookup(var.service_health_check, "unhealthy_threshold", "10")
    timeout             = lookup(var.service_health_check, "timeout", "10")
    interval            = lookup(var.service_health_check, "interval", "60")
    matcher             = lookup(var.service_health_check, "matcher", "200")
    path                = lookup(var.service_health_check, "path", "/healthcheck")
    port                = lookup(var.service_health_check, "port", var.service_port)
  }

  lifecycle {
    create_before_destroy = false
  }

}