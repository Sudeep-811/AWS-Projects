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
