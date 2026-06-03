variable "environment" {
  type        = string
  description = "The environment name (e.g., dev, prod)"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where this security group will live"
}