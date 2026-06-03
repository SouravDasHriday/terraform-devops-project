variable "vpc_cidr" {
  type        = string
  description = "The IP range block for the VPC"
}

variable "environment" {
  type        = string
  description = "The name of the environment (e.g., dev, prod)"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of IP ranges for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of IP ranges for private subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "The AWS data centers to spread resources across"
}