output "dev_website_url" {
  value       = "http://${module.ec2.public_ip}"
  description = "Click this link to see your live Dev environment!"
}

output "alb_website_url" {
  value       = "http://${module.alb.alb_dns_name}"
  description = "The permanent Load Balancer URL for the Dev environment"
}