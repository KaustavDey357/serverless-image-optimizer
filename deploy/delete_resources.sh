#!/bin/bash

BUCKET_NAME="your-unique-bucket-name-here"
FUNCTION_NAME="ImageOptimizerFunction"
ROLE_NAME="LambdaS3ExecutionRole"

aws lambda delete-function --function-name $FUNCTION_NAME
aws s3 rb s3://$BUCKET_NAME --force
aws iam detach-role-policy --role-name $ROLE_NAME --policy-arn arn:aws:iam::aws:policy/AWSLambdaExecute
aws iam delete-role --role-name $ROLE_NAME

