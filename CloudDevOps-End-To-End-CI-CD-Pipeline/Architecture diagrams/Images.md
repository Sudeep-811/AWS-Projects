# AWS CloudDevOps End-To-End CI/CD Pipeline - Architecture Diagrams

This document showcases the complete AWS infrastructure and application components deployed through the automated CI/CD pipeline.

## Table of Contents
- [Infrastructure Components](#infrastructure-components)
- [Application Services](#application-services)
- [Monitoring & Logging](#monitoring--logging)
- [Website Screenshots](#website-screenshots)

---

## Infrastructure Components

### VPC (Virtual Private Cloud)
![VPC Configuration](https://github.com/Sudeep-811/AWS-Projects/blob/0b268dd6b0c43be385dcc16fe9d272043191ecde/CloudDevOps-End-To-End-CI-CD-Pipeline/Architecture%20diagrams/vpc.png)

The Virtual Private Cloud provides isolated network environment for the entire infrastructure deployment.

### Subnets Configuration
![Subnets](https://github.com/Sudeep-811/AWS-Projects/blob/0b268dd6b0c43be385dcc16fe9d272043191ecde/CloudDevOps-End-To-End-CI-CD-Pipeline/Architecture%20diagrams/subnet.png)

Multi-AZ subnet configuration ensuring high availability and fault tolerance across different availability zones.

### Load Balancer Overview
![Load Balancer Overview](https://github.com/Sudeep-811/AWS-Projects/blob/0b268dd6b0c43be385dcc16fe9d272043191ecde/CloudDevOps-End-To-End-CI-CD-Pipeline/Architecture%20diagrams/lb1.png)

Application Load Balancer (ALB) distributing traffic across multiple container instances for high availability.

### Target Groups for Load Balancer
![Target Groups](https://github.com/Sudeep-811/AWS-Projects/blob/0b268dd6b0c43be385dcc16fe9d272043191ecde/CloudDevOps-End-To-End-CI-CD-Pipeline/Architecture%20diagrams/TG.png)

Target group configuration showing healthy instances and health check settings for the load balancer.

---

## Application Services

### ECR (Elastic Container Registry)
![Container Repository](https://github.com/Sudeep-811/AWS-Projects/blob/0b268dd6b0c43be385dcc16fe9d272043191ecde/CloudDevOps-End-To-End-CI-CD-Pipeline/Architecture%20diagrams/ECR.png)

Private Docker container registry storing the containerized jokes application images with automated CI/CD integration.

### ECS (Elastic Container Service) - Service Overview
![Container Service](https://github.com/Sudeep-811/AWS-Projects/blob/0b268dd6b0c43be385dcc16fe9d272043191ecde/CloudDevOps-End-To-End-CI-CD-Pipeline/Architecture%20diagrams/ECS1.png)

ECS service configuration managing the deployment and scaling of containerized applications.

### ECS - Running Clusters
![Running Clusters](https://github.com/Sudeep-811/AWS-Projects/blob/0b268dd6b0c43be385dcc16fe9d272043191ecde/CloudDevOps-End-To-End-CI-CD-Pipeline/Architecture%20diagrams/ECS2.png)

Active ECS Fargate clusters showing running tasks and resource utilization.

### ECS - Container Details
![Container Details](https://github.com/Sudeep-811/AWS-Projects/blob/0b268dd6b0c43be385dcc16fe9d272043191ecde/CloudDevOps-End-To-End-CI-CD-Pipeline/Architecture%20diagrams/ECS3.png)

Detailed view of container configurations, including CPU, memory allocation, and networking settings.

---

## Storage & State Management

### S3 Bucket
![S3 Bucket](https://github.com/Sudeep-811/AWS-Projects/blob/0b268dd6b0c43be385dcc16fe9d272043191ecde/CloudDevOps-End-To-End-CI-CD-Pipeline/Architecture%20diagrams/s3.png)

S3 bucket used for Terraform state management, ensuring consistent infrastructure state across deployments.

### DynamoDB Table
![DynamoDB Table](https://github.com/Sudeep-811/AWS-Projects/blob/0b268dd6b0c43be385dcc16fe9d272043191ecde/CloudDevOps-End-To-End-CI-CD-Pipeline/Architecture%20diagrams/dynamodb.png)

DynamoDB table providing state locking mechanism for Terraform to prevent concurrent modifications.

---

## Monitoring & Logging

### CloudWatch Logs
![CloudWatch Logs](https://github.com/Sudeep-811/AWS-Projects/blob/0b268dd6b0c43be385dcc16fe9d272043191ecde/CloudDevOps-End-To-End-CI-CD-Pipeline/Architecture%20diagrams/CWL.png)

Centralized logging solution capturing application logs, container logs, and infrastructure metrics for monitoring and debugging.

---

## Website Screenshots

### Jokes Website - Main Page
![Jokes Website](https://github.com/Sudeep-811/AWS-Projects/blob/0b268dd6b0c43be385dcc16fe9d272043191ecde/CloudDevOps-End-To-End-CI-CD-Pipeline/Architecture%20diagrams/JWA.png)

The deployed jokes web application accessible through the Application Load Balancer DNS endpoint.

### Jokes Website - Alternative View
![Jokes Website 2](https://github.com/Sudeep-811/AWS-Projects/blob/0b268dd6b0c43be385dcc16fe9d272043191ecde/CloudDevOps-End-To-End-CI-CD-Pipeline/Architecture%20diagrams/jw2.png)

Additional view of the jokes application demonstrating responsive design and functionality.

---

## Architecture Summary

This comprehensive infrastructure demonstrates:

- **High Availability**: Multi-AZ deployment with load balancing
- **Scalability**: ECS Fargate auto-scaling based on demand
- **Security**: Private subnets, security groups, and IAM role-based access
- **Automation**: Complete CI/CD pipeline with GitHub Actions
- **Monitoring**: CloudWatch integration for logs and metrics
- **Cost Optimization**: Serverless containers and efficient resource allocation
- **Infrastructure as Code**: Terraform for reproducible deployments
- **State Management**: S3 backend with DynamoDB locking

The entire infrastructure is provisioned and managed through Infrastructure as Code (Terraform) with automated CI/CD pipelines, ensuring consistent, reliable, and scalable cloud-native application deployment.

---

*This architecture represents a production-ready, enterprise-grade DevOps implementation showcasing modern cloud engineering practices and AWS best practices.*
