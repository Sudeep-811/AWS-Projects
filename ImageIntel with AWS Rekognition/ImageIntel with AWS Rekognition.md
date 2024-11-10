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
       <img src="https://github.com/Sudeep-811/AWS-Projects/blob/ada2aa3bebdcfbe74410b8ba182a63cf3259415d/ImageIntel%20with%20AWS%20Rekognition/s3_name%26region.png">
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
   - Choose a service- **S3**, select the event that should trigger the function, in our case event will be – `All object create events`. After this add the trigger.

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

# Code and Implementation:

## Lambda Function:
This Lambda function is designed to automatically analyze images that are uploaded to an S3 bucket. Here’s how it works step-by-step:

1. **Trigger**: Whenever an image is uploaded to the S3 bucket, the Lambda function can be triggered to start processing. This particular function is written to go through all images in the bucket, but you could configure it to only analyze newly uploaded images if that’s more useful.

2. **Image Processing**: The function lists all objects (images) in the S3 bucket. For each image, it calls a few Amazon Rekognition APIs to perform a detailed analysis. If any part of the process runs into an issue, the function logs the error and moves on to the next image, ensuring that one error doesn’t halt the entire process.

3. **Rekognition API Calls**: The Lambda function interacts with Rekognition to extract information about the image, such as objects, faces, and celebrity recognition. After gathering these results, it stores them in DynamoDB so that the data is easily accessible later on.

4. Below is the LambdaFn code that I have used-

```python
import json
import boto3

s3_client = boto3.client('s3')
rekognition_client = boto3.client('rekognition')
dynamodb_client = boto3.client('dynamodb')

def lambda_handler(event, context):
    bucket_name = 'testbucket811'  # Replace with your actual bucket name
    try:
        # Step 1: List all objects in the S3 bucket
        objects = s3_client.list_objects_v2(Bucket=bucket_name)
        if 'Contents' not in objects:
            print(f"No objects found in the bucket {bucket_name}")
            return {
                'statusCode': 404,
                'body': json.dumps(f"No objects found in bucket {bucket_name}")
            }

        # Process each object in the bucket
        for obj in objects['Contents']:
            object_key = obj['Key']
            print(f"Processing {object_key}")

            # Step 2: Detect labels (general objects)
            try:
                label_response = rekognition_client.detect_labels(
                    Image={'S3Object': {'Bucket': bucket_name, 'Name': object_key}},
                    MaxLabels=10,
                    MinConfidence=75
                )
                labels = [label['Name'] for label in label_response['Labels']]
                print(f"Labels for {object_key}: {labels}")
            except Exception as e:
                print(f"Error detecting labels for {object_key}: {e}")
                continue  # Skip to the next object

            # Step 3: Detect faces (if any faces are present in the image)
            try:
                face_response = rekognition_client.detect_faces(
                    Image={'S3Object': {'Bucket': bucket_name, 'Name': object_key}},
                    Attributes=['ALL']
                )
                faces = []
                for face in face_response['FaceDetails']:
                    faces.append({
                        'Confidence': face['Confidence'],
                        'AgeRange': face['AgeRange'],
                        'Gender': face['Gender']['Value'],
                        'Emotions': [emotion['Type'] for emotion in face['Emotions'] if emotion['Confidence'] > 75],
                        'Smile': face['Smile']['Value']
                    })
                print(f"Faces for {object_key}: {faces}")
            except Exception as e:
                print(f"Error detecting faces for {object_key}: {e}")
                continue  # Skip to the next object

            # Step 4: Recognize celebrities in the image
            try:
                celebrity_response = rekognition_client.recognize_celebrities(
                    Image={'S3Object': {'Bucket': bucket_name, 'Name': object_key}}
                )
                celebrities = []
                for celebrity in celebrity_response['CelebrityFaces']:
                    celebrities.append({
                        'Name': celebrity['Name'],
                        'Confidence': celebrity['MatchConfidence']
                    })
                print(f"Celebrities for {object_key}: {celebrities}")
            except Exception as e:
                print(f"Error recognizing celebrities for {object_key}: {e}")
                continue  # Skip to the next object

            # Step 5: Store the results in DynamoDB
            try:
                dynamodb_client.put_item(
                    TableName='ImageResults',
                    Item={
                        'ImageID': {'S': object_key},
                        'Labels': {'S': json.dumps(labels)},
                        'Faces': {'S': json.dumps(faces)},
                        'Celebrities': {'S': json.dumps(celebrities)}
                    }
                )
                print(f"Successfully saved analysis for {object_key} to DynamoDB.")
            except Exception as e:
                print(f"Error saving to DynamoDB for {object_key}: {e}")
                continue  # Skip to the next object

        return {
            'statusCode': 200,
            'body': json.dumps("Bucket analysis completed and results saved to DynamoDB.")
        }

    except Exception as e:
        print(f"Error processing bucket: {e}")
        return {
            'statusCode': 500,
            'body': json.dumps(f"An error occurred while processing the bucket: {e}")
        }
```


### API Usage:
This function makes use of three Amazon Rekognition APIs to get different insights from each image:

1. **Detect Labels**:
   - The `detect_labels` API identifies general objects and scenes in the image. For example, it might find labels like “Tree,” “Car,” or “Mountain.”
   - The function requests up to 10 labels for each image and only includes labels with a confidence score of 75% or higher.
   - Once the labels are detected, they’re stored as part of the image’s analysis results in DynamoDB.

2. **Detect Faces**:
   - The `detect_faces` API finds human faces in the image and analyzes attributes like age range, gender, emotions (e.g., happy, sad), and smile.
   - For each face, it returns detailed information about the detected person’s features, and only emotions with a high confidence level (over 75%) are included.
   - These face details are collected and saved in DynamoDB as part of the analysis results for that image.

3. **Recognize Celebrities**:
   - The `recognize_celebrities` API checks if any recognized celebrities appear in the image and returns their names along with a confidence score for the match.
   - If the function finds any celebrities, their details are also stored in DynamoDB.

### Storing Results in DynamoDB:
Once the Rekognition analysis is complete, the Lambda function saves the results in DynamoDB in a table called `ImageResults`. Here’s how it organizes the data:

1. **Table Structure**:
   - The DynamoDB table uses `ImageID` (the S3 image filename) as the primary key. This makes each image uniquely identifiable in the database.
   - For each image, it stores three main fields: **Labels**, **Faces**, and **Celebrities**.

2. **Data Format**:
   - **Labels**: The list of detected labels, stored in JSON format.
   - **Faces**: Details about each detected face, including attributes like age range, emotions, gender, and smile.
   - **Celebrities**: Names and confidence scores of any recognized celebrities.

3. **Saving Data**:
   - Using `put_item`, the function writes all these details to DynamoDB, creating an organized record of the analysis for each image.

### In a Nutshell:
This Lambda function automates the analysis of images in an S3 bucket. It uses Rekognition to detect labels, faces, and celebrities in each image, and then stores the results in DynamoDB. This setup provides a reliable and easily searchable way to store and access image analysis data for later use, making it ideal for applications where you need detailed image insights at scale.

# Testing & Results:

To ensure this whole architecture works as expected, testing involves verifying that each step performs correctly when images are uploaded, analyzed, and stored in DynamoDB.

1. **Upload Images**: I am going to upload a few images in my bucket, one of them is named as `Poster.jpg`.

   ![Bucket Content](https://github.com/Sudeep-811/AWS-Projects/blob/6d3be0c7c623ebc90a7831ba8e785f893ced43f9/ImageIntel%20with%20AWS%20Rekognition/bucketcontent.jpg)

2. **Check CloudWatch Logs**: Once the files are uploaded, we can check the CloudWatch logs to see if everything is working as expected.

   ![CloudWatch Logs](https://github.com/Sudeep-811/AWS-Projects/blob/6d3be0c7c623ebc90a7831ba8e785f893ced43f9/ImageIntel%20with%20AWS%20Rekognition/cloudwatchlogs.jpg)

3. **Check DynamoDB Table**: Finally, we go and check our DynamoDB table, and voila! The results are here.

   ![DynamoDB Table](https://github.com/Sudeep-811/AWS-Projects/blob/6d3be0c7c623ebc90a7831ba8e785f893ced43f9/ImageIntel%20with%20AWS%20Rekognition/resulttable.jpg)

4. **Image Poster.jpg**: The image `Poster.jpg` looks like this:

   ![Poster Image](https://github.com/Sudeep-811/AWS-Projects/blob/6d3be0c7c623ebc90a7831ba8e785f893ced43f9/ImageIntel%20with%20AWS%20Rekognition/poster.jpg)

   And the result shown by the DynamoDB table looks like this:

   ![DynamoDB Result](https://github.com/Sudeep-811/AWS-Projects/blob/6d3be0c7c623ebc90a7831ba8e785f893ced43f9/ImageIntel%20with%20AWS%20Rekognition/result.jpg)

## Conclusion:
Testing confirms that the Lambda function is properly analyzing images with Rekognition, accurately detecting and categorizing objects, faces, and celebrities, and reliably storing these results in DynamoDB. The results show that the function can handle a wide variety of image types and successfully logs any processing errors, making it ready for production use.

With ImageIntel, I set out to build an automated, intelligent way to analyze images using AWS. Every time an image is uploaded, it’s instantly processed to detect labels, faces, and even recognize celebrities—giving meaningful insights right at your fingertips. By connecting S3, Lambda, Rekognition, and DynamoDB, this project shows how we can combine cloud tools to create something powerful yet efficient.

Working on ImageIntel taught me a lot about event-driven architecture, serverless functions, and using AI in real-world scenarios. Along the way, I tackled challenges like setting up permissions, Lambda function timeouts, and other errors, which helped me strengthen my skills in AWS and cloud computing.

I’m excited about where this project could go next—adding a user-friendly dashboard, expanding to support other media types, or even sending real-time alerts when certain things are detected. Overall, this project was a rewarding experience, and I’m looking forward to applying what I’ve learned to future projects and roles where I can continue building impactful cloud-based solutions.
