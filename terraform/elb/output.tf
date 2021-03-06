output "http_listener_arn" {
  value = aws_lb_listener.http.arn
}

output "https_listener_arn" {
  value = aws_lb_listener.https.arn
}

output "alb_security_group" {
  value = aws_security_group.security_group.id
}