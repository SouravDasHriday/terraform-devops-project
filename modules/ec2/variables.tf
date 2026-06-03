variable "environment" {
  type        = string
  description = "The environment name"
}

variable "instance_type" {
  type        = string
  description = "The size of the server (e.g., t2.micro)"
  default     = "t2.micro" # We set a default so we don't accidentally get billed for a huge server!
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet where the server will live"
}

variable "security_group_id" {
  type        = string
  description = "The ID of the security group to attach"
}