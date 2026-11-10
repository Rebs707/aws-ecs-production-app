# Deployment and Rollback

## 1. Deployment model

This project uses Docker to validate application releases locally and
Terraform to define the intended AWS ECS Fargate infrastructure.

The local release simulation uses:

- Docker images tagged `v2` and `v3`
- A dedicated container named `ecs-release-test`
- Host port `5004`, mapped to application port `5001`
- The `/health` endpoint as the deployment health check

This is a local deployment simulation, not an AWS ECS deployment.

## 2. Deploy a release locally

Build the application image:

```bash
docker build -t aws-ecs-production-app:v3 .
```

## AWS target architecture

Terraform defines ECR, ECS Fargate, an Application Load Balancer,
security groups, and CloudWatch Logs.

It expects an existing VPC, at least two public subnets, and an
eligible ECS task execution role.

## AWS deployment limitation

AWS provisioning was not performed in the KodeKloud sandbox.
The sandbox did not provide an eligible ECS task execution role,
and IAM role creation was denied.

Terraform formatting and validation passed locally. This does not
prove that AWS provisioning or production deployment will succeed.

## Validation boundary

Application tests, Docker builds, container health checks,
hardened runtime checks, Terraform validation, CI commands, and
the local rollback simulation were tested locally.

No AWS production deployment is claimed.
