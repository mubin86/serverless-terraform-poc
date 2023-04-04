provider "aws" {
    region = "us-east-1"
}

locals {
  lambda_function_name = "${var.lambda_function_name}"
}

resource "aws_s3_bucket" "testing-bucket" {
  bucket = "m86-terraform-serverless-poc-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

module "dynamodb" {
  source = "./modules/dynamodb"

  environment  = var.environment
  read_capacity = var.read_capacity
  write_capacity = var.write_capacity
  gsi_read_capacity = var.gsi_read_capacity
  gsi_write_capacity = var.gsi_write_capacity

}

module "iam" {
  source = "./modules/iam"

  dynamodb_table_arn = module.dynamodb.dynamodb_table_arn
}
module "lambda" {
  source = "./modules/services/lambda"

  lambda_function_name  = local.lambda_function_name
  role_arn       = module.iam.lambda_role_arn
}
