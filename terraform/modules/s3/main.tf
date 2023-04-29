resource "aws_s3_bucket" "poc-bucket" {
  bucket = var.bucket_name
  # acl    = "public-read-write"

  tags = {
    Environment = var.environment
  }
}

resource "aws_s3_bucket_ownership_controls" "poc-bucket-control" {
  bucket = aws_s3_bucket.poc-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "poc-bucket-acl" {
  depends_on = [aws_s3_bucket_ownership_controls.poc-bucket-control]

  bucket = aws_s3_bucket.poc-bucket.id
  acl    = "private"
}


resource "aws_s3_bucket_notification" "s3-lambda-trigger" {
  bucket = aws_s3_bucket.poc-bucket.id
  lambda_function {
    lambda_function_arn = var.lambda_arn
    events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
  }
}
resource "aws_lambda_permission" "s3-lamda-permission" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${aws_s3_bucket.poc-bucket.id}"
}
