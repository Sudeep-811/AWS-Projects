



variable "aws_az_public_A" {
  description = "AWS region for the deployment"
  default     = "ap-south-1a"
}

variable "aws_az_public_B" {
  description = "AWS region for the deployment"
  default     = "ap-south-1b"
}

variable "aws_az_private_C" {
  description = "AWS region for the deployment"
  default     = "ap-south-1c"
}

variable "app_port" {
  description = "Port for the application"
  default     = 80
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "db_username" {
  description = "Database username"
  default     = "admin"
}

variable "db_password" {
  description = "Database password"
  default     = "securepassword123"
}

variable "aws_region" {
  description = "AWS region for the deployment"
  default     = "ap-south-1"
}