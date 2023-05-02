output "s3_bucket_info" {
  value = aws_s3_bucket.poc-bucket
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.poc-bucket.arn
}