output "s3_bucket_name" {
  value = module.s3.s3_bucket_name
}

output "sns_topic_arn" {
  value = module.sns.sns_topic_arn
}

output "lambda_cost_collector_arn" {
  value = module.lambda.cost_collector_arn
}

output "lambda_waste_analyzer_arn" {
  value = module.lambda.waste_analyzer_arn
}
