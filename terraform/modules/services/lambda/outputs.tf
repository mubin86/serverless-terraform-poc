output "lambda_arn" {
  value = aws_lambda_function.pocLambda.arn
}

output "lambda_invoke_url" {
  value = aws_lambda_function.pocLambda.invoke_arn
}