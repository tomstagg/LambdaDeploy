import json
import boto3
import requests
import logging

def handler (event, context):
  print("Received event: " + json.dumps(event, indent=2))

  s3 = boto3.resource('s3')
  for bucket in s3.buckets.all():
    print(bucket.name)

  dirt = s3.Bucket('dirt-media')
  dirt.put_object(Key='aFile.txt', Body='someText')
  response = requests.get('https://api.github.com/user')
  print(response.text)
  


handler({},{})