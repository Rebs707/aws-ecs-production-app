# 🚀 AWS ECS Fargate Deployment – Flask Application

## 📌 Project Overview
This project demonstrates an end-to-end deployment of a containerized Flask web application on AWS using ECS Fargate, Docker, and Amazon ECR. It follows a production-style cloud architecture with serverless container orchestration.

---

## 🏗️ Architecture

User → HTTP Request → ECS Fargate Service → Docker Container (Flask App)  
                             ↓  
                        Amazon ECR (Image Registry)

---

## ⚙️ Tech Stack

- Python (Flask)
- Docker
- AWS ECS (Fargate)
- Amazon ECR
- AWS IAM
- AWS VPC Networking

---

## 🚀 Deployment Workflow

1. Built Flask application locally
2. Containerized using Docker
3. Created ECR repository
4. Pushed Docker image to ECR
5. Created ECS Cluster (Fargate)
6. Defined Task Definition
7. Deployed ECS Service
8. Exposed application via public endpoint
9. Verified deployment using curl

---

## 🌐 Live Application

http://ec2-32-192-52-217.compute-1.amazonaws.com:5000

---

## 🧠 Key Learnings

- Container orchestration using AWS ECS Fargate
- Docker image lifecycle management
- IAM roles for ECS task execution
- Networking with AWS VPC and security groups
- Debugging real-world cloud deployment issues

---

## 📌 Status

✔ Deployment Completed  
✔ Verified via HTTP request  
✔ Cloud resources cleaned up  

---

## 📈 Future Improvements

- Add CI/CD pipeline using GitHub Actions
- Add Application Load Balancer (ALB)
- Add CloudWatch logging and monitoring
- Terraform-based infrastructure automation

