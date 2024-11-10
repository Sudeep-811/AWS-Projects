# Project Title: ImageIntel with AWS Rekognition

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

# Step-By-Step Guide

## A. Creating an S3 Bucket

1. **Log into AWS**  
   Go to the AWS Management Console and log in with your account.

2. **Find S3**  
   In the search bar at the top, type "S3" and select it. This will take you to the S3 service dashboard.

3. **Start Creating a Bucket**  
   On the S3 dashboard, click **Create bucket**. This will open a page where you can set up the basics of your new bucket.

4. **Name and Region**
   - **Bucket Name**: Choose a unique name (e.g., `testbucket811`) since bucket names must be unique across AWS.
   - **AWS Region**: Select a region close to you or your users for faster access.

   ![S3 Bucket Name and Region](https://github.com/Sudeep-811/AWS-Projects/blob/f34c73666c3244e6e68859b0a34649eb298b2d3d/ImageIntel%20with%20AWS%20Rekognition/S3_name%26region.jpg?raw=true)

5. **Customize Your Settings (Optional)**
   - **Block Public Access**: Keep this checked unless public access is needed.
   - **Bucket Versioning**: Enable if you want AWS to save every version of files that are updated.
   - **Tags**: Add tags to help organize and track usage.

6. **Create Your Bucket**  
   Once everything looks good, click **Create bucket** at the bottom of the page.

## B. Creating a Lambda Function

1. **Go to AWS Lambda**
   - Log in to the AWS Management Console.
   - In the search bar, type "Lambda" and select it.

2. **Click "Create Function"**  
   Click **Create function** on the main Lambda page to get started.

3. **Set Up Basic Details**
   - **Function Name**: Give your function a unique name.
   - **Runtime**: Select the language (e.g., Python 3.12).
   - **Permissions**: AWS creates a basic role with minimal permissions, which will need modification later.

   Go to the **Configuration** tab and select **Permissions**.

   ![Lambda Permissions](https://github.com/Sudeep-811/AWS-Projects/blob/f34c73666c3244e6e68859b0a34649eb298b2d3d/ImageIntel%20with%20AWS%20Rekognition/Lambda_Config.jpg?raw=true)

4. **Modify Role Permissions**  
   Click the role name to go to the IAM role window. Add the following policies:
   - **AmazonDynamoDBFullAccess**: Allows Lambda to write/modify DynamoDB tables.
   - **AmazonRekognitionReadOnlyAccess**: Allows Lambda to read data from Amazon Rekognition.
   - **AmazonS3ReadOnlyAccess**: Grants read-only access to Amazon S3.
   - **AWSLambdaBasicExecutionRole**: Basic permissions for Lambda to execute and log to CloudWatch.

   ![Lambda Roles](https://github.com/Sudeep-811/AWS-Projects/blob/f34c73666c3244e6e68859b0a34649eb298b2d3d/ImageIntel%20with%20AWS%20Rekognition/Lambda_roles.jpg?raw=true)

5. **Write Your Code**  
   Use the code editor to write your function’s code. Ensure you replace the bucket and DynamoDB table names with your own.

6. **Add a Trigger**  
   - Go to **Function overview** and click **Add trigger**.
   - Choose **S3** as the service and select **All object create events**.

7. **Configure Your Function (Optional)**  
   Adjust settings like memory allocation and timeout limits under **Configuration**.

8. **Test the Function**  
   Click **Test**, create a test event, and run it to see if everything works as expected.

9. **Deploy and Monitor**  
   AWS deploys your function automatically as you save changes. Use the **Monitoring** tab for metrics and logs.

## C. Creating a DynamoDB Table

1. **Open the DynamoDB Console**
   - Log in to your AWS Management Console.
   - In the search bar, type "DynamoDB" and select it.

2. **Click "Create Table"**  
   Look for the **Create table** button on the top right and click it.

3. **Configure Table Settings**
   - **Table Name**: Enter a unique name (e.g., `ImageResults`).
   - **Primary Key**: Set up the primary key.
     - **Partition Key**: Set as `ImageID` for storing image data.

4. **Set Up Table Settings (Optional)**  
   Leave the rest of the settings as default.

5. **Review and Create**  
   Review your table settings and click **Create**.

6. **Done! Your Table is Created**  
   Once created, you'll be taken to the table’s dashboard with information about the table’s configuration.
