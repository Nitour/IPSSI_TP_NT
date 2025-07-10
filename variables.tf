variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_cidr" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "database_subnet_cidrs" {
  type = list(string)
}

variable "enable_nat_instance" {
  type = bool
}

variable "ami_filter" {
  type = object({
    name_pattern = string
    owners       = list(string)
    architecture = string
  })

  default = {
    name_pattern = "debian-11-amd64-*"
    owners       = ["136693071363"]
    architecture = "x86_64"
  }
}
