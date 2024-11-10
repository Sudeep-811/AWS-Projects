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

# Step-By-Step Guide:

## A. Creating S3 bucket-

1. **Log into AWS**  
   First, go to the AWS Management Console and log in with your account.

2. **Find S3**  
   In the search bar at the top, type “S3” and select it. This will take you to the S3 service dashboard.

3. **Start Creating a Bucket**  
   On the S3 dashboard, click **Create bucket**. This will open a page where you can set up the basics of your new bucket.

4. **Name and Region**  
   - **Bucket Name**: Choose a name that’s unique across all of AWS (this part is important since bucket names can’t be reused by others). Make it something easy to remember and related to what you'll store in it. [In my case I used `testbucket811`]
   - **AWS Region**: Select a region that’s close to you or your users for faster access.  

   <div align="center">
       <img src="https://github.com/Sudeep-811/AWS-Projects/blob/f34c73666c3244e6e68859b0a34649eb298b2d3d/ImageIntel%20with%20AWS%20Rekognition/S3_name%26region.jpg?raw=true" alt="S3 Name and Region">
   </div>

5. **Customize Your Settings (Optional)**  
   You’ll see a few options here:  
   - **Block Public Access**: By default, AWS blocks public access to keep your data safe. Keep this checked unless you specifically need public access.
   - **Bucket Versioning**: You can enable versioning if you want AWS to save every version of files that are updated or overwritten.
   - **Tags**: Adding tags can help with organizing and tracking usage across projects.

6. **Create Your Bucket**  
   Once everything looks good, click **Create bucket** at the bottom of the page.

## B. Creating Lambda Function-

Creating a Lambda function on AWS is pretty straightforward. Here’s how to do it:

1. **Go to AWS Lambda**  
   - First, log in to the AWS Management Console.
   - In the search bar, type **Lambda** and select it from the list. This will take you to the Lambda service dashboard.

2. **Click “Create Function”**  
   On the main Lambda page, you’ll see a **Create function** button – click on that to get started.

3. **Set Up Basic Details**  
   - **Function name**: Give your function a unique name that describes what it will do.
   - **Runtime**: Select the language your function will use, like Python, Node.js, or Java (In my case I used Python 3.12).
   - **Permissions**: AWS will create a basic role with minimal permissions for you. But we will have to change this role later as out function will be using multiple AWS service.
   - After this go ahead and create function.
   - Once it is created got to the configuration column and select Permission on the left side.  

   <div align="center">
       <img src="https://github.com/Sudeep-811/AWS-Projects/blob/f34c73666c3244e6e68859b0a34649eb298b2d3d/ImageIntel%20with%20AWS%20Rekognition/Lambda_Config.jpg?raw=true" alt="Lambda Config">
   </div>

   - You will see a basic role is already created for the function and we will have to modify it. Click on role name and it will re-direct you to the IAM role window. From there click on **Add permissions > Attach policies**. It will open another window and you will have to select below roles from the list. [`AmazonDynamoDBFullAccess`, `AmazonRekognitionReadOnlyAccess`, `AmazonS3ReadOnlyAccess`, `AWSLambdaBasicExecutionRole`]

     1. **`AmazonDynamoDBFullAccess`**- This policy will allow Lambda Function to write/modify tables in DyanamoDB.
     2. **`AmazonRekognitionReadOnlyAccess`**- This policy allows the access to Amazon Rekognition to read data.
     3. **`AmazonS3ReadOnlyAccess`**- Grants read-only access to Amazon S3 resources.
     4. **`AWSLambdaBasicExecutionRole`**- This policy provides basic permissions required for AWS Lambda functions to execute and log to Amazon CloudWatch.  
     
     <div align="center">
         <img src="https://github.com/Sudeep-811/AWS-Projects/blob/f34c73666c3244e6e68859b0a34649eb298b2d3d/ImageIntel%20with%20AWS%20Rekognition/Lambda_roles.jpg?raw=true" alt="Lambda Roles">
     </div>

4. **Write Your Code in AWS Lambda Function**  
   - Now, you’ll see a code editor where you can start writing your function’s code.
   - I am attaching the code below in the “Code and Implementation” section. You can use the same code for your project but make sure you replace bucket name and DynamoDB table name by your own bucket and table.

5. **Add a Trigger**  
   - Trigger is needed for Lambda function to automatically respond when a new file added to an S3 bucket, go to the Function overview section and click **Add trigger**.
   - Choose a service- **S3**, select the event that should trigger the function, in our case event will be – All object create events. After this add the trigger.

6. **Configure Your Function (Optional)**  
   In the **Configuration** tab, you’ll find settings for things like memory allocation and timeout limits. Adjust these depending on your function’s needs. For example, if your function will process large files, increasing the memory or timeout might help.

7. **Test the Function**  
   - At the top of the editor, you’ll see a **Test** button. Click it, and create a new test event with input data.
   - Run the test to see if everything works as expected. The console will show output, logs, and any errors, which can be helpful for debugging.

8. **Deploy and Monitor**  
   - AWS automatically deploys your function as you save changes, so once it’s saved, it’s ready to go!
   - You can check the **Monitoring** tab to view CloudWatch metrics and logs to see how your function is performing.

   And that’s it! Your Lambda function is live and ready to use. You can trigger it manually, schedule it, or set it up to respond to specific events.

## C. Creating a DynamoDB table-

1. **Open the DynamoDB Console**
   - First, log into your AWS Management Console.
   - In the search bar, type **DynamoDB** and select it from the results to go to the DynamoDB dashboard.

2. **Click "Create Table"**  
   Once you're in the DynamoDB console, look for the **Create table** button on the top right and click it.

3. **Configure Table Settings**  
   You’ll now see a form where you’ll define the table’s settings. Here are the fields you need to fill out:
   - **Table Name**: Enter a name for your table. This name must be unique within your DynamoDB instance. [I used `ImageResults`]
   - **Primary Key**: Every DynamoDB table requires a primary key. You’ll choose one or more attributes to uniquely identify each item in the table.
     - **Partition Key (mandatory)**: This is the main identifier for your table’s items. It can be a string, number, or binary. In this case, we are creating a table to store image data, so we are using `ImageID`.
     - **Sort Key (optional)**: This is an additional key that helps you organize items within the partition. If you only need a single key, you can skip this. If you have multiple attributes that uniquely identify an item (like a `ImageID` and Timestamp for events), use a sort key.

4. **Set Up Table Settings (Optional)**  
   Leave the rest of the settings as default.

5. **Review and Create**  
   After filling out the configuration details:
   - Review your table settings to make sure everything looks good.
   - Click the **Create** button.

6. **Done! Your Table is Created**  
   - DynamoDB will create the table. It might take a few moments.
   - Once the table is ready, you’ll be taken to the table’s dashboard, where you can see information about it, including the primary key, capacity, and other settings.
