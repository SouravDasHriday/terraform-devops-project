output "alb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "The permanent DNS URL of the load balancer"
}