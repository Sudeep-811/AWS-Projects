# ImageIntel with AWS Rekognition

## Project Title
**ImageIntel with AWS Rekognition**

### Tagline
Automated Image Analysis Pipeline using AWS Rekognition, Lambda, and DynamoDB.

## Summary
ImageIntel automatically analyzes images uploaded to an AWS S3 bucket using AWS Rekognition’s label detection, celebrity recognition, and face detection APIs. The results are then stored in DynamoDB, enabling you to easily track and access insights for each image. This project showcases a seamless, serverless solution for intelligent image processing.

## Key Technologies Used
- **AWS S3**: For easy image storage and triggering automated processes.
- **AWS Lambda**: For serverless image processing without managing infrastructure.
- **Amazon Rekognition**: For intelligent image analysis, detecting labels, faces, and even celebrities.
- **DynamoDB**: To store results in a fast and scalable database.

## The Architecture
A simple architecture diagram showing how each component works together:

- **AWS S3**: For easy image storage and triggering automated processes.
- **AWS Lambda**: For serverless image processing without managing infrastructure.
- **Amazon Rekognition**: For intelligent image analysis, detecting labels, faces, and even celebrities.
- **DynamoDB**: To store results in a fast and scalable database.

![Architecture Diagram](https://github.com/Sudeep-811/AWS-Projects/blob/f3717eefa51d9b5b522182275ad6565cb5209e6a/ImageIntel%20with%20AWS%20Rekognition/Imageintel%20Architecture.png?raw=true)

## How It Works
1. **Image Upload**: Users upload an image to an S3 bucket.
2. **Lambda Trigger**: The S3 upload triggers a Lambda function.
3. **Rekognition Analysis**: The Lambda function calls Rekognition to analyze the image for labels, faces, and celebrities.
4. **Results in DynamoDB**: The Lambda function then stores the analysis results in DynamoDB for easy retrieval.
