output "nat_instance_public_ip" {
  value       = module.ec2_nat.nat_public_ip
  description = "Adresse IP publique de l'instance NAT"
}

output "infrastructure_summary" {
  value = {
    vpc = {
      id   = module.vpc.vpc_id
      cidr = module.vpc.vpc_cidr
    }
    s3 = {
      bucket_name = module.s3.bucket_name
    }
    instances = {
      web_servers = module.ec2_web.instance_details
    }
    endpoints = {
      web_urls   = module.ec2_web.public_urls
      nat_ip     = module.ec2_nat.nat_public_ip
    }
  }
}

output "alb_url" {
  value       = module.alb.alb_dns_name
  description = "URL publique du load balancer"
}
