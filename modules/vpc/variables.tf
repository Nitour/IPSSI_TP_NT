variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs for private subnets"
}

variable "database_subnet_cidrs" {
  type        = list(string)
  description = "CIDRs for DB subnets"
}

variable "nat_instance_id" {
  type        = string
  description = "ID de l'instance NAT"
}

variable "nat_network_interface_id" {
  type        = string
  default     = null
  description = "ID de l'interface réseau principale de la NAT instance"
}

