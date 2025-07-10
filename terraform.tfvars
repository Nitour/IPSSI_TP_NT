vpc_cidr             = "10.0.0.0/16"
availability_zones   = ["us-east-1a", "us-east-1b"]

public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
database_subnet_cidrs = ["10.0.21.0/24", "10.0.22.0/24"]

enable_nat_instance = true
environment         = "dev"

ami_filter = {
  name_pattern = "debian-11-amd64-*"
  owners       = ["136693071363"]
  architecture = "x86_64"
}
