<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ImageIntel with AWS Rekognition</title>
</head>
<body>

  <h1>ImageIntel with AWS Rekognition</h1>
  <h2>Automated Image Analysis Pipeline using AWS Rekognition, Lambda, and DynamoDB</h2>

  <section>
    <h3>Summary</h3>
    <p>
      ImageIntel automatically analyzes images uploaded to an AWS S3 bucket using AWS Rekognition’s label detection, celebrity recognition, and face detection APIs. The results are then stored in DynamoDB, enabling you to easily track and access insights for each image. This project showcases a seamless, serverless solution for intelligent image processing.
    </p>
  </section>

  <section>
    <h3>Key Technologies Used</h3>
    <ul>
      <li><strong>AWS S3:</strong> For easy image storage and triggering automated processes.</li>
      <li><strong>AWS Lambda:</strong> For serverless image processing without managing infrastructure.</li>
      <li><strong>Amazon Rekognition:</strong> For intelligent image analysis, detecting labels, faces, and even celebrities.</li>
      <li><strong>DynamoDB:</strong> To store results in a fast and scalable database.</li>
    </ul>
  </section>

  <section>
    <h3>The Architecture</h3>
    <p>A simple architecture diagram showing how each component works together:</p>
    <ul>
      <li><strong>AWS S3:</strong> For easy image storage and triggering automated processes.</li>
      <li><strong>AWS Lambda:</strong> For serverless image processing without managing infrastructure.</li>
      <li><strong>Amazon Rekognition:</strong> For intelligent image analysis, detecting labels, faces, and even celebrities.</li>
      <li><strong>DynamoDB:</strong> To store results in a fast and scalable database.</li>
    </ul>
  </section>

</body>
</html>

