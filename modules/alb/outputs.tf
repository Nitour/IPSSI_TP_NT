output "alb_dns_name" {
  value       = aws_lb.web_alb.dns_name
  description = "Nom DNS public du ALB"
}
