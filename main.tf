module "s3" {
  source      = "./modules/s3"
  environment = var.environment
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "ec2_nat" {
  source              = "./modules/ec2_nat"
  enable_nat_instance = var.enable_nat_instance
  subnet_id           = module.vpc.public_subnet_ids[0]
  sg_id               = module.sg.nat_sg_id
}

module "ec2_web" {
  source             = "./modules/ec2_web"
  key_pair_name      = "terraform"
  ami_filter         = var.ami_filter
  instance_count     = 2
  instance_type      = "t2.micro"
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_id  = module.sg.web_sg_id
}

module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr              = var.vpc_cidr
  availability_zones    = var.availability_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  nat_instance_id       = module.ec2_nat.nat_instance_id
  nat_network_interface_id = module.ec2_nat.nat_network_interface_id
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.sg.alb_sg_id
  web_instance_ids  = module.ec2_web.web_instance_ids
}
