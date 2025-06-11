import boto3
from PIL import Image
import io
import os
import base64

s3 = boto3.client('s3')

def lambda_handler(event, context):
    print("Event received:", event)
    bucket = event['Records'][0]['s3']['bucket']['name']
    key    = event['Records'][0]['s3']['object']['key']
    
    response = s3.get_object(Bucket=bucket, Key=key)
    image_content = response['Body'].read()
    
    img = Image.open(io.BytesIO(image_content))
    img = img.convert('RGB')
    
    buffer = io.BytesIO()
    img.save(buffer, format="JPEG", optimize=True, quality=60)
    buffer.seek(0)
    
    new_key = "optimized-" + key
    s3.put_object(Bucket=bucket, Key=new_key, Body=buffer, ContentType='image/jpeg')
    
    return {
        'statusCode': 200,
        'body': f'Image optimized and saved as {new_key}'
    }

