variable "aws_region" {
  description = "AWS region for the deployment."
  type        = string
  default     = "us-east-1"
}

variable "app_name" {
  description = "Application and resource naming prefix."
  type        = string
  default     = "aws-ecs-production-app"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "production"
}

variable "vpc_id" {
  description = "Existing VPC ID in which to deploy the application."
  type        = string
}

variable "public_subnet_ids" {
  description = "At least two public subnet IDs in different Availability Zones."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_ids) >= 2
    error_message = "Provide at least two public subnet IDs."
  }
}

variable "execution_role_arn" {
  description = "ARN of an existing ECS task execution role with required ECR and CloudWatch permissions."
  type        = string
}

variable "container_port" {
  description = "Port exposed by the application container."
  type        = number
  default     = 5001
}

variable "image_tag" {
  description = "Container image tag to deploy from ECR."
  type        = string
  default     = "v3"
}

variable "desired_count" {
  description = "Desired number of ECS tasks."
  type        = number
  default     = 1
}
