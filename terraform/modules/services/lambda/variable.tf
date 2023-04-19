# variable "lambda_function_name" {
#   description = "The name of the Lambda function"
# }

variable "role_arn" {
  description = "The arn of the lambda role"
}

variable "lambda_layer_arn" {
  description = "The arn of the lambda layer"
}
variable "lambdas" {
  default = []
  type = list(string)
}

# variable "lambda_role" {
#   description = "IAM role attached to Lambda function - ARN"
# }

# variable "lambda_file_name" {
#   description = "Path to lambda code zip"
# }