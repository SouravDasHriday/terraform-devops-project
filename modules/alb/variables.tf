variable "environment" {
  type        = string
  description = "The environment name"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs where the ALB will live"
}

variable "security_group_id" {
  type        = string
  description = "The ID of the security group"
}

variable "instance_id" {
  type        = string
  description = "The ID of the EC2 instance to route traffic to"
}