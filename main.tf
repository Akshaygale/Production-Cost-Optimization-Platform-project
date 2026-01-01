module "iam" {
  source       = "./terraform/iam"
  project_name = var.project_name
}

module "s3" {
  source       = "./terraform/s3"
  project_name = var.project_name
}

module "sns" {
  source          = "./terraform/sns"
  project_name    = var.project_name
  email_recipient = var.email_recipient
}

module "lambda" {
  source          = "./terraform/lambda"
  project_name    = var.project_name
  lambda_runtime  = var.lambda_runtime
  lambda_role_arn = module.iam.lambda_role_arn

  s3_bucket_name = module.s3.s3_bucket_name
  sns_topic_arn  = module.sns.sns_topic_arn
}

module "eventbridge" {
  source = "./terraform/eventbridge"
  project_name = var.project_name

  cost_collector_arn = module.lambda.cost_collector_arn
  waste_analyzer_arn = module.lambda.waste_analyzer_arn
}

