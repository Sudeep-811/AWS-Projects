# CloudDevOps-End-To-End-CI-CD-Pipeline

## Table of Contents
- [Project Summary](#project-summary)  
- [Architecture](#architecture)  
- [Technologies Used](#technologies-used)  
- [Getting Started](#getting-started)  
  - [Prerequisites](#prerequisites)  
  - [Infrastructure Deployment](#infrastructure-deployment)  
  - [Application Build & Deploy](#application-build--deploy)  
  - [CI/CD Workflows](#cicd-workflows)  
  - [Teardown Script](#teardown-script)  
- [Results](#results)  
- [Challenges & Solutions](#challenges--solutions)  
- [Future Enhancements](#future-enhancements)  
- [Conclusion](#conclusion)

---

## Project Summary
This project demonstrates an **end-to-end Cloud DevOps pipeline** where a containerized web application is automatically built, deployed, and managed on **AWS ECS Fargate** using **Terraform** and **GitHub Actions**.  

The goal is to showcase a real-world CI/CD workflow that provisions cloud infrastructure, deploys application containers, and supports full lifecycle management (from setup to teardown).  

---

## Architecture
![Architecture Diagram](docs/architecture.png)

**Workflow Overview:**
1. **Code Commit:** Developer pushes changes to GitHub.  
2. **CI/CD Pipeline:** GitHub Actions builds the Docker image, pushes it to **Amazon ECR**, and applies **Terraform** to provision or update infrastructure.  
3. **Infrastructure:** Terraform provisions **VPC, Subnets, Security Groups, ECS Cluster, Fargate Service, ALB, IAM Roles, and ECR Repository**.  
4. **Deployment:** ECS Fargate pulls the container image from ECR and serves traffic via Application Load Balancer.  
5. **Teardown:** A cleanup script destroys infrastructure and purges leftover images.  

---

## Technologies Used
- **Cloud:** AWS (ECS, Fargate, ECR, VPC, ALB, IAM, Route53)  
- **Infrastructure as Code:** Terraform  
- **CI/CD:** GitHub Actions  
- **Containerization:** Docker  
- **Programming/Scripting:** Bash, YAML (GitHub workflows)  
- **Version Control:** Git, GitHub  

---

## Getting Started

### Prerequisites
- AWS Account with programmatic access (Access Key & Secret Key)  
- [Terraform](https://www.terraform.io/downloads) installed locally  
- [Docker](https://www.docker.com/) installed locally  
- GitHub repository with Actions enabled  

---

### Infrastructure Deployment
1. Clone the repository:  
   ```bash
   git clone https://github.com/your-username/CloudDevOps-End-To-End-CI-CD-Pipeline.git
   cd CloudDevOps-End-To-End-CI-CD-Pipeline
   
    ```

2. Initialize and apply Terraform:

```bash
terraform init
terraform apply -auto-approve
```

3. Verify AWS resources (VPC, ECS Cluster, ALB, ECR repository) are created.

## Application Build & Deploy

### 1. Build Docker image:

```bash
docker build -t jokes-app .
```

### 2. Authenticate with ECR & push:

```bash
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com
docker tag jokes-app:latest <account_id>.dkr.ecr.<region>.amazonaws.com/jokes-app:latest
docker push <account_id>.dkr.ecr.<region>.amazonaws.com/jokes-app:latest
```

### 3. ECS Fargate service automatically pulls the image & updates the application.

## CI/CD Workflows

The project uses **GitHub Actions** to automate:

* **CI:** Build and push Docker image to ECR.
* **CD:** Run Terraform apply to provision infrastructure and deploy application.
* **Cleanup:** On teardown workflow, destroy infra and delete images in ECR.

Workflows are defined in `.github/workflows/`.

## Teardown Script

A helper script `destroy-all.sh` ensures safe cleanup by:

* Deleting all images inside the ECR repository.
* Running `terraform destroy -auto-approve` to remove infra.

Run:

```bash
./destroy-all.sh
```

## Results

* Successfully deployed a containerized **jokes web application** with **end-to-end automation**.
* Application accessible through a public **Application Load Balancer DNS**.
* Infrastructure fully reproducible via Terraform and CI/CD workflows.
* One-click teardown for cost management.

## Challenges & Solutions

* **Challenge:** Terraform failed to delete ECR repository if images existed.
   * **Solution:** Wrote a Bash script (`destroy-all.sh`) to purge images before `terraform destroy`.
* **Challenge:** Managing Terraform state safely in CI/CD.
   * **Solution:** Used AWS S3 backend and state locking with DynamoDB.
* **Challenge:** Ensuring seamless GitHub Actions authentication with AWS.
   * **Solution:** Configured OIDC-based authentication to avoid hardcoding secrets.

## Future Enhancements

* Add monitoring & alerting with **Prometheus/Grafana** or **CloudWatch**.
* Implement blue/green or canary deployments.
* Add cost monitoring using AWS Budgets & Alerts.
* Integrate security scans (Snyk, Trivy) into CI pipeline.

## Conclusion

This project demonstrates a **production-style Cloud DevOps workflow** by combining AWS services, Terraform automation, Docker, and GitHub Actions.

It highlights practical problem-solving (infrastructure automation, CI/CD integration, teardown management) and provides a strong foundation for scaling real-world applications.

## License

This project is licensed under the MIT License.

## Contact

👤 **Sudeep Kumar Verma**

* LinkedIn
* GitHub
