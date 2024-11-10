# ImageIntel with AWS Rekognition

## Project Overview
ImageIntel is an automated image analysis pipeline built with AWS services. It analyzes images uploaded to an S3 bucket using Rekognition’s label detection, celebrity recognition, and face detection APIs, storing the results in DynamoDB.

**Tagline:** Automated Image Analysis Pipeline using AWS Rekognition, Lambda, and DynamoDB.

## Key Technologies
- **AWS S3**: Image storage and event triggering.
- **AWS Lambda**: Serverless function for image processing.
- **Amazon Rekognition**: Detects labels, faces, and celebrities.
- **DynamoDB**: Stores analysis results.

## Architecture Diagram
![Architecture Diagram](https://github.com/Sudeep-811/AWS-Projects/blob/f3717eefa51d9b5b522182275ad6565cb5209e6a/ImageIntel%20with%20AWS%20Rekognition/Imageintel%20Architecture.png?raw=true)

## How It Works
1. **Image Upload**: Users upload an image to S3.
2. **Lambda Trigger**: Upload triggers the Lambda function.
3. **Rekognition Analysis**: The function calls Rekognition to analyze the image.
4. **Results in DynamoDB**: Analysis results are stored in DynamoDB for easy retrieval.

## Code and Implementation
The Lambda function code handles image uploads, calls Rekognition’s APIs, and stores results in DynamoDB. Key functionalities:

- `detect_labels`: Identifies objects and scenes.
- `detect_faces`: Detects faces and attributes (age, gender, emotions).
- `recognize_celebrities`: Recognizes known celebrities.

## Testing and Results
Upload an image (e.g., *Poster.jpg*) to test the pipeline. Check DynamoDB to view analysis results, and use CloudWatch for logs to verify function performance.

## Conclusion
This project shows the power of cloud automation, using AWS Rekognition for instant insights on image uploads. I learned how to design a serverless architecture and work with AI-based APIs for practical applications.

Future possibilities include adding a dashboard, expanding to video analysis, or sending alerts for specific detections. This project was a rewarding experience, and I’m excited to bring these skills into future roles.
