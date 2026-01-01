variable "project_name" {
  description = "Project name for naming resources"
  type        = string
}

variable "lambda_runtime" {
  description = "Lambda runtime environment"
  type        = string
}

variable "lambda_role_arn" {
  description = "IAM role ARN for Lambda"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name to save cost reports"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS topic ARN for alerts"
  type        = string
}
