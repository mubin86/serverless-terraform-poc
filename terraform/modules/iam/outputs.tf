output "lambda_role_arn" {
  value = aws_iam_role.lambdaRole.arn
}

output "lambda_role_id" {
  value = aws_iam_role.lambdaRole.id
}

output "s3_lambda_role_arn" {
  value = aws_iam_role.s3LambdaRole.arn
}

