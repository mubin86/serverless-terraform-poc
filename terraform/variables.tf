variable "environment" {
  type    = string
  default = "dev"
}

variable "write_capacity" {
  type    = number
  default = 1
}

variable "read_capacity" {
  type    = string
  default = 1
}

variable "gsi_write_capacity" {
  type    = number
  default = 3
}

variable "gsi_read_capacity" {
  type    = number
  default = 3
}

# variable "lambda_function_name" {
#   type        = string
#   description = "The name of the Lambda function"
# }