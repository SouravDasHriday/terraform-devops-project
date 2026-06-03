terraform {
  backend "s3" {
    # CRITICAL: Use your exact bucket name!
    bucket       = "devops-project-tfstate-sourav-2026"
    key          = "environments/dev/terraform.tfstate" # Saves specifically in a 'dev' folder
    region       = "ap-southeast-1"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

# 1. Call the VPC Module
module "vpc" {
  source               = "../../modules/vpc"
  environment          = "dev"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["ap-southeast-1a", "ap-southeast-1b"]
}

# 2. Call the Security Group Module
module "security_group" {
  source      = "../../modules/security-group"
  environment = "dev"
  
  # We grab the vpc_id directly from the vpc module's output!
  vpc_id      = module.vpc.vpc_id
}

# 3. Call the EC2 Module
module "ec2" {
  source            = "../../modules/ec2"
  environment       = "dev"
  instance_type     = "t2.micro"
  
  # We grab the FIRST public subnet ID from the vpc module's output array
  subnet_id         = module.vpc.public_subnet_ids[0] 
  
  # We grab the security group ID from the security_group module's output
  security_group_id = module.security_group.security_group_id
}