data "archive_file" "lambdaDefinitions" {
  for_each = toset(var.lambdas)

  type        = "zip"
  source_dir = "${path.module}/../../../../serverless-api/handlers/${each.key}"
  output_path = "${path.module}/../../../../serverless-api/build/pocGame/${each.key}.zip"
}

resource "aws_lambda_function" "pocLambdas" {
  for_each = toset(var.lambdas)

  function_name    = each.key
  role             = var.role_arn
  handler          = "${each.key}.handler"
  filename         = "${path.module}/../../../../serverless-api/build/pocGame/${each.key}.zip"
  source_code_hash = data.archive_file.lambdaDefinitions[each.key].output_base64sha256

  runtime     = "nodejs16.x"
  memory_size = 128
  timeout     = 3

  layers = [var.lambda_layer_arn]
}
