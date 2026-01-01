variable "project_name" {
  default = "Production-Cost-Optimization-Platform"
  description = "Project name for naming resources"
}

variable "email_recipient" {
  description = "Email to send alerts to"
  type        = string
}