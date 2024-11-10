

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background: #f4f4f4; color: #333; }
        .container { width: 80%; margin: auto; overflow: hidden; }
        h1, h2, h3 { color: #333; }
        h1 { text-align: center; padding: 20px 0; }
        .section { padding: 20px; background: #fff; margin-bottom: 20px; }
        code { background: #eee; padding: 2px 6px; font-size: 90%; color: #d14; }
        .architecture img { width: 100%; height: auto; }
    </style>
</head>
<body>
    <div class="container">
        <h1>ImageIntel with AWS Rekognition</h1>
        <div class="section">
            <h2>Project Overview</h2>
            <p>ImageIntel is an automated image analysis pipeline built with AWS services. It analyzes images uploaded to an S3 bucket using Rekognition’s label detection, celebrity recognition, and face detection APIs, storing the results in DynamoDB.</p>
            <p><strong>Tagline:</strong> Automated Image Analysis Pipeline using AWS Rekognition, Lambda, and DynamoDB.</p>
        </div>
    <div class="section">
            <h2>Key Technologies</h2>
            <ul>
                <li><strong>AWS S3</strong>: Image storage and event triggering.</li>
                <li><strong>AWS Lambda</strong>: Serverless function for image processing.</li>
                <li><strong>Amazon Rekognition</strong>: Detects labels, faces, and celebrities.</li>
                <li><strong>DynamoDB</strong>: Stores analysis results.</li>
            </ul>
        </div>
  <div class="section architecture">
            <h2>Architecture Diagram</h2>
            <img src="https://github.com/Sudeep-811/AWS-Projects/blob/f3717eefa51d9b5b522182275ad6565cb5209e6a/ImageIntel%20with%20AWS%20Rekognition/Imageintel%20Architecture.png?raw=true" alt="Architecture Diagram" />
        </div>
 <div class="section">
            <h2>How It Works</h2>
            <ol>
                <li><strong>Image Upload</strong>: Users upload an image to S3.</li>
                <li><strong>Lambda Trigger</strong>: Upload triggers the Lambda function.</li>
                <li><strong>Rekognition Analysis</strong>: The function calls Rekognition to analyze the image.</li>
                <li><strong>Results in DynamoDB</strong>: Analysis results are stored in DynamoDB for easy retrieval.</li>
            </ol>
        </div>
    <div class="section">
            <h2>Code and Implementation</h2>
            <p>The Lambda function code handles image uploads, calls Rekognition’s APIs, and stores results in DynamoDB. Key functionalities:</p>
            <ul>
                <li><code>detect_labels</code>: Identifies objects and scenes.</li>
                <li><code>detect_faces</code>: Detects faces and attributes (age, gender, emotions).</li>
                <li><code>recognize_celebrities</code>: Recognizes known celebrities.</li>
            </ul>
        </div>

  <div class="section">
            <h2>Testing and Results</h2>
            <p>Upload an image (e.g., <em>Poster.jpg</em>) to test the pipeline. Check DynamoDB to view analysis results, and use CloudWatch for logs to verify function performance.</p>
        </div>

   <div class="section">
            <h2>Conclusion</h2>
            <p>This project shows the power of cloud automation, using AWS Rekognition for instant insights on image uploads. I learned how to design a serverless architecture and work with AI-based APIs for practical applications.</p>
            <p>Future possibilities include adding a dashboard, expanding to video analysis, or sending alerts for specific detections. This project was a rewarding experience, and I’m excited to bring these skills into future roles.</p>
        </div>
    </div>
</body>
</html>
