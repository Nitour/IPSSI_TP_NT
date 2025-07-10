variable "ami_filter" {
  type = object({
    name_pattern = string
    owners       = list(string)
    architecture = string
  })
}

variable "key_pair_name" {
  type = string
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}
