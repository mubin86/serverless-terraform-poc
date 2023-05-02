data "archive_file" "lambdaDefinitions" {
  for_each = toset(var.lambdas)

  type        = "zip"
  source_dir = "${path.module}/../../../../serverless-api/handlers/${each.key}"
  output_path = "${path.module}/../../../../serverless-api/build/pocGame/${each.key}.zip"
}

resource "aws_lambda_function" "pocLambdas" {
  for_each = toset(var.lambdas)

  function_name    = each.key
  role             =  startswith(each.key, "upload") ? var.s3_triggered_lambda_role_arn : var.role_arn
  handler          = "${each.key}.handler"
  filename         = "${path.module}/../../../../serverless-api/build/pocGame/${each.key}.zip"
  source_code_hash = data.archive_file.lambdaDefinitions[each.key].output_base64sha256

  runtime     = "nodejs16.x"
  memory_size = 128
  timeout     = 3

  layers = [var.lambda_layer_arn]
}

data "archive_file" "s3TriggeredLambdaDefinition" {
  type        = "zip"
  source_dir = "${path.module}/../../../../serverless-api/handlers/s3-event"
  output_path = "${path.module}/../../../../serverless-api/build/s3LambdaEvent/s3-event.zip"
}

resource "aws_lambda_function" "s3TriggeredLambda" {
  function_name    = var.s3_triggered_lambda_function_name
  handler          = "s3-event.handler" 
  role             = var.s3_triggered_lambda_role_arn

  filename         = "${path.module}/../../../../serverless-api/build/s3LambdaEvent/s3-event.zip"
  source_code_hash = data.archive_file.s3TriggeredLambdaDefinition.output_base64sha256

  runtime     = "nodejs16.x"
  memory_size = 128
  timeout     = 3
}

