output "api_gw_endpoint" {
  value = aws_apigatewayv2_api.poc-lambda-api.api_endpoint
}