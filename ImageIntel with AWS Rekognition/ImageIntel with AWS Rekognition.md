<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ImageIntel with AWS Rekognition</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #f4f4f4;
            color: #333;
        }
        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
        }
        h1, h2, h3 {
            color: #333;
        }
        h1 {
            text-align: center;
            padding: 20px 0;
        }
        .section {
            padding: 20px;
            background: #fff;
            margin-bottom: 20px;
        }
        ul, ol {
            padding-left: 20px;
        }
        .architecture img {
            width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>ImageIntel with AWS Rekognition</h1>
        
   <div class="section">
            <h2>Project Title</h2>
            <p><strong>ImageIntel with AWS Rekognition</strong></p>
            <h3>Tagline</h3>
            <p>Automated Image Analysis Pipeline using AWS Rekognition, Lambda, and DynamoDB.</p>
        </div>

   <div class="section">
            <h2>Summary</h2>
            <p>ImageIntel automatically analyzes images uploaded to an AWS S3 bucket using AWS Rekognition’s label detection, celebrity recognition, and face detection APIs. The results are then stored in DynamoDB, enabling you to easily track and access insights for each image. This project showcases a seamless, serverless solution for intelligent image processing.</p>
        </div>

  <div class="section">
            <h2>Key Technologies Used</h2>
            <ul>
                <li><strong>AWS S3</strong>: For easy image storage and triggering automated processes.</li>
                <li><strong>AWS Lambda</strong>: For serverless image processing without managing infrastructure.</li>
                <li><strong>Amazon Rekognition</strong>: For intelligent image analysis, detecting labels, faces, and even celebrities.</li>
                <li><strong>DynamoDB</strong>: To store results in a fast and scalable database.</li>
            </ul>
        </div>

   <div class="section architecture">
            <h2>The Architecture</h2>
            <p>A simple architecture diagram showing how each component works together:</p>
            <ul>
                <li><strong>AWS S3</strong>: For easy image storage and triggering automated processes.</li>
                <li><strong>AWS Lambda</strong>: For serverless image processing without managing infrastructure.</li>
                <li><strong>Amazon Rekognition</strong>: For intelligent image analysis, detecting labels, faces, and even celebrities.</li>
                <li><strong>DynamoDB</strong>: To store results in a fast and scalable database.</li>
            </ul>
            <img src="https://github.com/Sudeep-811/AWS-Projects/blob/f3717eefa51d9b5b522182275ad6565cb5209e6a/ImageIntel%20with%20AWS%20Rekognition/Imageintel%20Architecture.png?raw=true" alt="Architecture Diagram" />
        </div>

  <div class="section">
            <h2>How It Works</h2>
            <ol>
                <li><strong>Image Upload</strong>: Users upload an image to an S3 bucket.</li>
                <li><strong>Lambda Trigger</strong>: The S3 upload triggers a Lambda function.</li>
                <li><strong>Rekognition Analysis</strong>: The Lambda function calls Rekognition to analyze the image for labels, faces, and celebrities.</li>
                <li><strong>Results in DynamoDB</strong>: The Lambda function then stores the analysis results in DynamoDB for easy retrieval.</li>
            </ol>
        </div>
    </div>
</body>
</html>
