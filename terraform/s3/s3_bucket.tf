resource "random_id" "s3_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "cost_reports" {
  bucket = "${var.project_name}-reports-${random_id.s3_suffix.hex}"
  
  tags = {
    Project     = var.project_name
    Environment = "Production"
  }
}

resource "aws_s3_bucket_acl" "cost_reports_acl" {
  bucket = aws_s3_bucket.cost_reports.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "cost_reports_versioning" {
  bucket = aws_s3_bucket.cost_reports.id

  versioning_configuration {
    status = "Enabled"
  }
}
