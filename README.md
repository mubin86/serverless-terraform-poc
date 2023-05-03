# Serverless Terraform AWS API Gateway Lambda DynamoDB S3 Dynamoose
 
## Pre-requisites
1. Access to an AWS account
2. aws-cli is installed and configured
3. Terraform is installed
4. Serverless is installed

# Deploying the infrastructure
  ### Deploying the terraform part
 ```
  cd terraform
  terraform init
  terraform apply
 ```
 ### Deploying the serverless part
 ```
 cd serverless-api
 serverless deploy
 ```
 ***Though we are handling all the things by terraform so can be skipped***
 
# Clarification
The `terraform` directory defines a small set of infrastructure elements using `modules`: Lambda, Layer, API Gateway, DynamoDB, S3 and necessary IAM roles for all of these. The key here is the `modules` directory where trying to put some best practices along with `variables.tf` and `terraform.tfvars` file by passing the necessary attributes and populates acordingly.

The `serverless-api` directory is a Serverless Framework project which mainly contains the lambda handler implementation and the additional code of functionality done with `Layers`. Handlers basically implemented different sort of queries in DynamoDB through `Dynamoose` and `S3 Lambda trigger` functionality is ongoing and also many more to come :grinning:.



