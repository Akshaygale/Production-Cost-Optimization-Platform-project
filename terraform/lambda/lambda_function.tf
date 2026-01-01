resource "aws_lambda_function" "cost_collector" {
  filename      = "code/cost_collector.zip"
  function_name = "${var.project_name}-cost-collector"
  role          = var.lambda_role_arn
  handler       = "cost_collector.lambda_handler"
  runtime       = var.lambda_runtime
  timeout       = 300
  memory_size   = 128

  environment {
    variables = {
      S3_BUCKET     = var.s3_bucket_name
      SNS_TOPIC_ARN = var.sns_topic_arn
    }
  }
}

resource "aws_lambda_function" "waste_analyzer" {
  filename      = "code/waste_analyzer.zip"
  function_name = "${var.project_name}-waste-analyzer"
  role          = var.lambda_role_arn
  handler       = "waste_analyzer.lambda_handler"
  runtime       = var.lambda_runtime
  timeout       = 300
  memory_size   = 128

  environment {
    variables = {
      S3_BUCKET     = var.s3_bucket_name
      SNS_TOPIC_ARN = var.sns_topic_arn
    }
  }
}

output "cost_collector_arn" {
  value = aws_lambda_function.cost_collector.arn
}

output "waste_analyzer_arn" {
  value = aws_lambda_function.waste_analyzer.arn
}
