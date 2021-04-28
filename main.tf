provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "alpha-terraform-dev"
    key = "tf-terraform"
    region = "eu-west-1"
  }
}

resource "aws_lambda_function" "lambda_function" {
  role = aws_iam_role.lambda_role.arn
  handler = "lambda.handler"
  runtime = "python3.6"
  filename = "./dist/lambda.zip"
  source_code_hash = filebase64sha256("./dist/lambda.zip")
  timeout = 300
  function_name = "basic_lambda"
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
  role = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}