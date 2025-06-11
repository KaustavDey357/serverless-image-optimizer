#!/bin/bash

BUCKET_NAME="your-unique-bucket-name-here"
FUNCTION_NAME="ImageOptimizerFunction"
ROLE_NAME="LambdaS3ExecutionRole"

# 1. Create S3 bucket
aws s3 mb s3://$BUCKET_NAME

# 2. Create IAM role
aws iam create-role --role-name $ROLE_NAME --assume-role-policy-document file://deploy/trust-policy.json

# 3. Attach policy
aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn arn:aws:iam::aws:policy/AWSLambdaExecute

# 4. Zip and deploy Lambda
cd lambda
zip function.zip handler.py
cd ..

aws lambda create-function --function-name $FUNCTION_NAME \
  --zip-file fileb://lambda/function.zip \
  --handler handler.lambda_handler \
  --runtime python3.11 \
  --role arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):role/$ROLE_NAME

# 5. Set up S3 trigger manually via console or via CLI (more complex)

