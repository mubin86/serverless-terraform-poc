variable "bucket_name" {
  description = "name of the bucket"
  type = string
}

variable "environment" {
  description = "environment of the bucket"
  type = string
}

variable "lambda_arn" {
  description = "The arn of the s3 triggered lambda"
  type = string
}