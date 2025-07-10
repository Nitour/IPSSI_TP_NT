output "nat_instance_id" {
  value = var.enable_nat_instance ? aws_instance.nat[0].id : null
}

output "nat_network_interface_id" {
  value = var.enable_nat_instance ? aws_instance.nat[0].primary_network_interface_id : null
}
output "nat_public_ip" {
  value = aws_instance.nat[0].public_ip
}
