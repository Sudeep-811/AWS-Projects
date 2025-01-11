
output "load_balancer_dns" {
  description = "ALB DNS Name"
  value       = aws_lb.app.dns_name
}

output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.default.endpoint
}
