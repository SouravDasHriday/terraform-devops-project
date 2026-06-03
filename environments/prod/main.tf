terraform {
  backend "s3" {
    bucket       = "devops-project-tfstate-sourav-2026" # Use your exact bucket!
    key          = "environments/prod/terraform.tfstate" # IMPORTANT: Now it saves in a 'prod' folder
    region       = "ap-southeast-1"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

# 1. Call the VPC Module for Prod
module "vpc" {
  source               = "../../modules/vpc"
  environment          = "prod"
  vpc_cidr             = "10.1.0.0/16" # Changed to 10.1
  public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
  availability_zones   = ["ap-southeast-1a", "ap-southeast-1b"]
}

# 2. Call the Security Group Module for Prod
module "security_group" {
  source      = "../../modules/security-group"
  environment = "prod"
  vpc_id      = module.vpc.vpc_id
}

# 3. Call the EC2 Module for Prod
module "ec2" {
  source            = "../../modules/ec2"
  environment       = "prod"
  instance_type     = "t2.micro"
  subnet_id         = module.vpc.public_subnet_ids[0] 
  security_group_id = module.security_group.security_group_id
}