# Scalable Web Application Deployment on AWS via Terraform

## Summary
Building scalable and reliable web applications is key to ensuring a great user experience. For this project, I deployed a web application on AWS using Terraform to manage the infrastructure. The project demonstrates how to create a highly available and cost-effective architecture using Auto Scaling Groups (ASG), Application Load Balancers (ALB), and Amazon RDS with the help of Infrastructure-as-Code (IaC).  
By automating everything with Terraform, I’ve ensured that this setup is easy to reproduce and scalable enough to handle increasing traffic.

---

## Architecture

### 1. Overview
The architecture follows a 3-tier structure:
- **Presentation Layer**: Application Load Balancer (ALB) to distribute traffic across multiple EC2 instances.
- **Application Layer**: EC2 instances running the web application, managed by Auto Scaling Groups.
- **Data Layer**: RDS MySQL database for persistent data storage.

### 2. Key Components

- **Application Load Balancer (ALB)**:
  - Ensures high availability by distributing traffic across healthy EC2 instances.
  - Monitors the health of instances through health checks.
  
- **Auto Scaling Group (ASG)**:
  - Dynamically adjusts the number of EC2 instances based on demand.
  - Ensures fault tolerance and cost efficiency.

- **RDS MySQL Database**:
  - Provides a managed relational database solution.
  - Configured for high availability with multi-AZ deployments.

## Diagram

![Scalable Web App Architecture](https://github.com/Sudeep-811/AWS-Projects/blob/27dacd90c1fd6a806d92d15c55074e75580512d7/Scalable%20Web%20App%20(Iac)/Architecture.gif)

---

## Technologies Used
1. **Terraform**: Infrastructure as Code (IaC) tool to automate AWS resource provisioning.
2. **AWS**:
   - **EC2**: Compute instances for running the application.
   - **ALB**: Application Load Balancer for traffic distribution.
   - **RDS**: Managed database service.
   - **VPC**: Virtual Private Cloud for network isolation.
   - **ASG**: To provision the number of EC2 instances based on demand.
   - **NAT Gateway**: Allows private subnet instances to access the internet.
   - **IAM**: Identity and Access Management for security.
3. **Linux (Ubuntu)**: Operating system for EC2 instances.
4. **Apache**: Web server for serving static and dynamic content.
5. **GitHub**: Version control for Terraform configuration files.
6. **Visual Studio Code (VS Code)**: IDE for writing and managing code.

---

## Step-by-Step Guide

### 1. Here’s what you’ll need to get started:
- Terraform installed on your system.
- AWS CLI configured with valid credentials.
- A basic understanding of AWS services and Terraform.

**Important Note**:  
To authenticate and interact with AWS through Terraform, you need to provide your AWS Access Key ID and Secret Access Key. You can do this in one of the following ways:

#### 1. In your Terraform code:
```hcl
provider "aws" {
  access_key = "your-access-key-id"
  secret_key = "your-secret-access-key"
  region     = "ap-south-1"
}
```

#### 2. 2-	Using AWS SDK Default Credentials Locations: Alternatively, you can store your AWS credentials in the default AWS SDK locations. For Windows, the default path is:
C:\Users\REXX\.aws\credentials
Make sure your credentials are saved there in the following format:
```hcl
[default]
aws_access_key_id = your-access-key-id
aws_secret_access_key = your-secret-access-key
```
