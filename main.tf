terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "devops-project-tfstate-sourav-2026"
    key            = "global/s3/terraform.tfstate"
    region         = "ap-southeast-1"
    
    # REMOVE the dynamodb_table line and add this:
    use_lockfile   = true  
    
    encrypt        = true
  }

}

provider "aws" {
  region = "ap-southeast-1" # Select my region
}

# Create the S3 Bucket for Remote State:
resource "aws_s3_bucket" "terraform_state" {
  # CRITICAL: Change "devops-project-tfstate-sourav-2026" Set unique name so it is globally unique!
  bucket        = "devops-project-tfstate-sourav-2026" 
  force_destroy = true
}

# Enable versioning so we keep a history of our infrastructure state files
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

