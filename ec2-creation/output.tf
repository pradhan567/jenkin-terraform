output "alb_dns_name" {
  description = "The DNS name of the Jenkins ALB"
  value       = aws_lb.jenkins_alb.dns_name
}
