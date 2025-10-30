provider "aws" {
  region = "us-east-1"
}

# S3 bucket
resource "aws_s3_bucket" "media_bucket" {
  bucket = "media-streaming-bucket-nirmal"
}

# Block all public access 
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.media_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Lambda function 
resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_lambda_function" "media_lambda" {
  function_name = "mediaLambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "python3.9"

  filename = "lambda_function_payload.zip"
}
