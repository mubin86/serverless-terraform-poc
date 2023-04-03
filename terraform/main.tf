provider "aws" {
    region = "us-east-1"
    version = "~> 4.61"
}

resource "aws_s3_bucket" "testing-bucket" {
  bucket = "m86-terraform-serverless-poc-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}