output "web_public_ips" {
  value = aws_instance.ec2_web[*].public_ip
}
output "web_instance_ids" {
  value       = aws_instance.ec2_web[*].id
  description = "Liste des IDs des instances EC2 Web"
}


output "instance_details" {
  value = [
    for instance in aws_instance.ec2_web :
    {
      id        = instance.id
      public_ip = instance.public_ip
      private_ip = instance.private_ip
      name      = instance.tags["Name"]
    }
  ]
}

output "public_urls" {
  value = [
    for instance in aws_instance.ec2_web :
    "http://${instance.public_ip}"
  ]
}
