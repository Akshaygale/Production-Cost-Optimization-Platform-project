variable "aws_region" {
  description = "AWS Region"
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name for naming resources"
  default     = "Production-Cost-Optimization-Platform"
}

variable "lambda_runtime" {
  description = "Lambda runtime environment"
  default     = "python3.11"
}

variable "email_recipient" {
  description = "Email to receive cost alerts"
  default     = "akshaygale19@gmail.com"
}
