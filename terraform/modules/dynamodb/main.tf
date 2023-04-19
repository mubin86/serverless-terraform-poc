resource "aws_dynamodb_table" "poc-game-dynamodb-table" {
  name           = "${var.environment}-poc-game"
  billing_mode   = "PROVISIONED"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = "AccountId"
  range_key      = "CreatedAt"

  attribute {
    name = "AccountId"
    type = "S"
  }

  attribute {
    name = "CreatedAt"
    type = "N"
  }

  attribute {
    name = "OriginCountry"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  attribute {
    name = "Score"
    type = "N"
  }

  # ttl {
  #   attribute_name = "TimeToExist"
  #   enabled        = false
  # }

  global_secondary_index {
    name               = "GameTitleIndex"
    hash_key           = "GameTitle"
    range_key          = "OriginCountry"
    write_capacity     = var.gsi_write_capacity
    # must be greater than or equal to the base table capacity bcz under 
    # the hood some kind of repication happened with the new composite primary key with eventual consistency

    read_capacity      = var.gsi_read_capacity
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }

   local_secondary_index {
    name               = "ScoreIndex"
    range_key          = "Score"
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }

  tags = {
    Name        = "${var.environment}-business"
    Environment = "${var.environment}-environment"
  }
}