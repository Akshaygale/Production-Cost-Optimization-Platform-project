resource "aws_sns_topic" "cost_alerts" {
  name = "${var.project_name}-alerts"
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.cost_alerts.arn
  protocol  = "email"
  endpoint  = var.email_recipient
}

output "sns_topic_arn" {
  value = aws_sns_topic.cost_alerts.arn
}
