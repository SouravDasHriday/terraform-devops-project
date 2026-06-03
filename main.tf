terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "devops-project-tfstate-sourav-2026"
    key            = "global/s3/terraform.tfstate" # The file path inside S3
    region         = "ap-southeast-1"
    dynamodb_table = "devops-project-tfstate-locks"
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

# Create the DynamoDB Table for State Locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "devops-project-tfstate-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID" # This attribute name is strictly required by Terraform!

  attribute {
    name = "LockID"
    type = "S"
  }
}
