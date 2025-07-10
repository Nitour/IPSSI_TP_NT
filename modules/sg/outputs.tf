output "nat_sg_id" {
  value       = aws_security_group.nat_sg.id
  description = "ID du security group NAT"
}

output "web_sg_id" {
  value       = aws_security_group.web_sg.id
  description = "ID du security group WEB"
}

output "alb_sg_id" {
  value       = aws_security_group.alb_sg.id
  description = "ID du Security Group pour l'ALB"
}

