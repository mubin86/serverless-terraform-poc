provider "aws" {
  region = "us-east-1"
}

locals {
  # lambda_function_name = var.lambda_function_name
  lambdas = ["add-game-info", "game-country-stat", "game-score-info"]
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

  environment        = var.environment
  read_capacity      = var.read_capacity
  write_capacity     = var.write_capacity
  gsi_read_capacity  = var.gsi_read_capacity
  gsi_write_capacity = var.gsi_write_capacity

}

module "iam" {
  source = "./modules/iam"

  dynamodb_table_arn = module.dynamodb.dynamodb_table_arn
}

module "lambda" {
  source = "./modules/services/lambda"

  role_arn = module.iam.lambda_role_arn
  lambdas  = local.lambdas
}

module "api-gateway" {
  source = "./modules/api-gateway"

  poc_lamda_api_name = "testing-poc-game"
  # lambda_invoke_url  = module.lambda.lambda_invoke_url
  # lambda_arn         = module.lambda.lambda_arn
  lambdas = module.lambda.lambdas
}

