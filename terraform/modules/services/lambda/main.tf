data "archive_file" "lambdaZip" {
  type        = "zip"
  source_file = "${path.module}/../../../../serverless-api/game/handler.js"
  output_path = "${path.module}/../../../../serverless-api/files/game-handler.zip"
}

resource "aws_lambda_function" "pocLambda" {
  function_name    = var.lambda_function_name
  role             = var.role_arn
  handler          = "handler.gameHandler"
  filename         = "${path.module}/../../../../serverless-api/files/game-handler.zip"
  source_code_hash = data.archive_file.lambdaZip.output_base64sha256

  runtime     = "nodejs16.x"
  memory_size = 128
  timeout     = 3
}
