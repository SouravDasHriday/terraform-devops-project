output "security_group_id" {
  value       = aws_security_group.web_sg.id
  description = "The ID of the web security group"
}