provider "aws" {
  region = "us-east-1"
}

locals {
  lambdas = ["add-game-info", "game-country-stat", "game-score-info"]
  endpoints = {
    add-game-info : {
      path   = "add-player-game-info"
      method = "POST"
    },
    game-country-stat : {
      path   = "game-country-participant"
      method = "GET"
    }
    game-score-info : {
      path   = "player-score-info"
      method = "GET"
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
}

module "poc-lambda-layer" {
  source = "./modules/services/lambda-layers"
}

module "lambda" {
  source = "./modules/services/lambda"

  role_arn = module.iam.lambda_role_arn
  lambdas  = local.lambdas
  lambda_layer_arn = module.poc-lambda-layer.poc_lambda_layer_arn
}

module "api-gateway" {
  source = "./modules/api-gateway"

  poc_lamda_api_name = "testing-poc-game"
  # lambda_invoke_url  = module.lambda.lambda_invoke_url
  # lambda_arn         = module.lambda.lambda_arn
  lambdas   = module.lambda.lambdas
  endpoints = local.endpoints
}

