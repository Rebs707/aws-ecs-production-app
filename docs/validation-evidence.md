# Validation Evidence Register

## Application
- Five pytest tests passed.
- Root endpoint returned HTTP 200.
- Health endpoint returned HTTP 200 with healthy JSON.

## Docker and runtime
- v3 image built successfully.
- Application ran as a non-root user.
- Hardened runtime checks passed:
  - Read-only root filesystem
  - Temporary writable /tmp
  - All Linux capabilities dropped
  - no-new-privileges enabled

## Infrastructure and CI
- Terraform formatting check passed.
- Terraform validation passed.
- GitHub Actions workflow created with application test,
  Docker build, and Terraform validation jobs.
- CI commands tested locally.

## Release and rollback
- v2 and v3 containers verified locally.
- Deliberately unhealthy candidate failed its health check.
- Deployment script restored the previous v3 image.
- Restored v3 returned HTTP 200 from both endpoints.

## AWS deployment boundary
AWS provisioning was not performed. The KodeKloud sandbox
did not provide an eligible ECS task execution role, and
IAM role creation was denied.

Terraform validation is not proof of successful AWS provisioning.
No AWS production deployment is claimed.

## Evidence provenance
Results are based on terminal outputs and user-confirmed checks
during the local project validation process.
