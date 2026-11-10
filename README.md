# AWS ECS Production Application

A containerized Flask application with Docker hardening, automated testing, Terraform-based AWS infrastructure configuration, CI validation, and deployment rollback simulation.

## Project Overview

This project demonstrates an end-to-end cloud application delivery workflow, from application development and containerization to infrastructure definition, validation, release testing, and rollback.

The target deployment architecture uses Amazon ECS Fargate, Amazon ECR, an Application Load Balancer, security groups, and Amazon CloudWatch Logs.

## Architecture

See [Architecture Diagram](diagrams/architecture.md).

### Target AWS Components

| Component | Purpose |
|---|---|
| Amazon ECR | Container image repository |
| Amazon ECS Fargate | Container orchestration |
| Application Load Balancer | HTTP traffic distribution |
| AWS VPC | Network isolation |
| Security Groups | Traffic access control |
| CloudWatch Logs | Application log collection |
| Terraform | Infrastructure as Code |

## Application

The Flask application exposes two endpoints:

| Endpoint | Purpose |
|---|---|
| `/` | Application response |
| `/health` | Application health check |

Application port: `5001`

## Container Engineering

The Docker image includes:

- Python 3.13 slim base image
- Gunicorn application server
- Non-root application user
- Container health check
- Reduced runtime dependencies
- Docker build-context exclusions

The container was also tested with:

- Read-only root filesystem
- Temporary writable `/tmp` filesystem
- Linux capabilities dropped
- `no-new-privileges` enabled

## Infrastructure as Code

The `terraform/` directory defines:

- ECR repository with image scanning and immutable tags
- ECS cluster and Fargate task definition
- ECS service
- Application Load Balancer and target group
- Security groups
- CloudWatch log group
- ECS deployment circuit breaker with rollback

The configuration accepts an existing VPC, public subnets, and ECS task execution role as inputs.

## CI/CD

GitHub Actions workflow: `.github/workflows/ci.yml`

Three validation jobs:

1. Application tests using pytest
2. Docker image build
3. Terraform formatting and validation

The workflow currently validates builds and configuration. It does not publish images or deploy to AWS.

## Deployment and Rollback

A local deployment simulation uses Docker image versions `v2` and `v3`.

The deployment script:

- Starts a candidate container
- Checks the application health endpoint
- Detects failed releases
- Restores the previously running image
- Verifies rollback health

A controlled failure test demonstrated automatic restoration of the previous healthy v3 image.

See [Deployment and Rollback](docs/deployment-and-rollback.md).

## Validation Results

- Five Flask application tests passed.
- Docker v3 image built successfully.
- Application and health endpoints verified.
- Non-root container execution verified.
- Hardened container runtime checks passed.
- Terraform formatting and validation passed.
- CI workflow commands tested locally.
- v2 and v3 release checks passed.
- Controlled deployment failure and rollback simulation passed.

See [Validation Evidence Register](docs/validation-evidence.md).

## AWS Deployment Status

**AWS provisioning was not performed in the KodeKloud sandbox.**

The sandbox did not provide an eligible ECS task execution role, and IAM role creation was denied.

Terraform configuration was formatted and validated locally. Actual AWS resource provisioning and production deployment remain unverified.

The project therefore distinguishes local engineering validation from AWS deployment validation.

## Repository Structure

```text
.
├── .github/
│   └── workflows/
│       └── ci.yml
├── app/
│   ├── app.py
│   └── requirements.txt
├── diagrams/
│   └── architecture.md
├── docs/
│   ├── deployment-and-rollback.md
│   └── validation-evidence.md
├── scripts/
│   └── deploy-local.sh
├── terraform/
│   ├── main.tf
│   ├── outputs.tf
│   ├── variables.tf
│   ├── versions.tf
│   └── terraform.tfvars.example
├── tests/
│   └── test_app.py
├── Dockerfile
├── .dockerignore
├── .gitignore
├── pytest.ini
├── requirements-dev.txt
└── README.md
