# output "lambda_arn" {
#   value = aws_lambda_function.pocLambda.arn
# }

# output "lambda_invoke_url" {
#   value = aws_lambda_function.pocLambda.invoke_arn
# }

output "lambdas" {
  description = "lambda objects created"
  value = aws_lambda_function.pocLambdas
}

output "s3_triggered_lambda" {
  description = "s3 triggered lambda object created"
  value = aws_lambda_function.s3TriggeredLambda
}