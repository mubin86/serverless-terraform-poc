resource "aws_apigatewayv2_api" "poc-lambda-api" {
  name          = var.poc_lamda_api_name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "poc-lambda-api-stage" {
  api_id      = aws_apigatewayv2_api.poc-lambda-api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "poc-lambda-api-integration" {
  api_id             = aws_apigatewayv2_api.poc-lambda-api.id
  integration_uri    = var.lambda_invoke_url
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "poc-lambda-route" {
  api_id    = aws_apigatewayv2_api.poc-lambda-api.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.poc-lambda-api-integration.id}"
}


resource "aws_lambda_permission" "api-gw-lambda-permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.poc-lambda-api.execution_arn}/*/*"
}