# Daily cost collection
resource "aws_cloudwatch_event_rule" "daily_cost_scan" {
  name                = "${var.project_name}-daily-cost-collection"
  schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "cost_collector_target" {
  rule = aws_cloudwatch_event_rule.daily_cost_scan.name
  arn  = var.cost_collector_arn
}

resource "aws_lambda_permission" "allow_eventbridge_cost_collector" {
  statement_id  = "AllowEventBridgeInvokeCostCollector"
  action        = "lambda:InvokeFunction"
  function_name = var.cost_collector_arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_cost_scan.arn
}

# Daily waste analysis
resource "aws_cloudwatch_event_rule" "daily_waste_analysis" {
  name                = "${var.project_name}-daily-waste-analysis"
  schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "waste_analyzer_target" {
  rule = aws_cloudwatch_event_rule.daily_waste_analysis.name
  arn  = var.waste_analyzer_arn
}

resource "aws_lambda_permission" "allow_eventbridge_waste_analyzer" {
  statement_id  = "AllowEventBridgeInvokeWasteAnalyzer"
  action        = "lambda:InvokeFunction"
  function_name = var.waste_analyzer_arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_waste_analysis.arn
}
