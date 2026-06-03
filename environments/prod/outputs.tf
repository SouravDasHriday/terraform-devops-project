output "prod_website_url" {
  value       = "http://${module.ec2.public_ip}"
  description = "Click this link to see your live Production environment!"
}