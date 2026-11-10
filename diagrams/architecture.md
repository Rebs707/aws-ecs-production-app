# AWS ECS Production Application Architecture

## Target AWS architecture

```mermaid
flowchart TB
    User[Application User]
    ALB[Application Load Balancer]
    SG[Task Security Group]
    ECS[ECS Fargate Service]
    Task[Flask Application Container]
    ECR[Amazon ECR]
    CW[Amazon CloudWatch Logs]
    IAM[Existing ECS Task Execution Role]
    VPC[Existing AWS VPC and Public Subnets]

    User --> ALB
    ALB --> SG
    SG --> ECS
    ECS --> Task
    ECR --> Task
    IAM --> ECS
    Task --> CW
    VPC --> ALB
    VPC --> ECS
