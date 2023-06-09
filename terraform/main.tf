provider "aws" {
  region = "us-east-1"
}

locals {
  lambdas = ["add-game-info", "game-country-stat", "game-score-info", "upload-image-to-s3"]
  endpoints = {
    add-game-info : {
      path   = "add-player-game-info"
      method = "POST"
    },
    game-country-stat : {
      path   = "game-account-info/{accountId}/{createdBeforeInMonth}"
      method = "GET"
    }
    game-score-info : {
      path   = "game-country-score-info/{gameTitle}/{originCountry}"
      method = "GET"
    }
    upload-image-to-s3 : {
      path   = "upload-profile-image"
      method = "POST"
    }
  }
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
  s3_bucket_arn = module.s3.s3_bucket_arn
}

module "poc-lambda-layer" {
  source = "./modules/services/lambda-layers"
}

module "lambda" {
  source = "./modules/services/lambda"

  role_arn = module.iam.lambda_role_arn
  lambdas  = local.lambdas
  lambda_layer_arn = module.poc-lambda-layer.poc_lambda_layer_arn
  s3_triggered_lambda_function_name = var.s3_triggered_lambda_function_name
  s3_triggered_lambda_role_arn = module.iam.s3_lambda_role_arn
}

module "api-gateway" {
  source = "./modules/api-gateway"

  poc_lamda_api_name = "testing-poc-game"
  # lambda_invoke_url  = module.lambda.lambda_invoke_url
  # lambda_arn         = module.lambda.lambda_arn
  lambdas   = module.lambda.lambdas
  endpoints = local.endpoints
}

module "s3" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
  environment = var.environment
  lambda_arn = module.lambda.s3_triggered_lambda.arn
}

