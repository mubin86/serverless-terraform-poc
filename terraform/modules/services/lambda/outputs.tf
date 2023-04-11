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