#!/usr/bin/env bash
set -Eeuo pipefail

IMAGE="${1:?Usage: ./scripts/deploy-local.sh IMAGE}"
CONTAINER_NAME="${CONTAINER_NAME:-ecs-release-test}"
HOST_PORT="${HOST_PORT:-5004}"
CONTAINER_PORT=5001
HEALTH_URL="http://127.0.0.1:${HOST_PORT}/health"

if ! docker image inspect "$IMAGE" >/dev/null 2>&1; then
  echo "ERROR: Image not found: $IMAGE"
  exit 1
fi

PREVIOUS_IMAGE=""
if docker container inspect "$CONTAINER_NAME" >/dev/null 2>&1; then
  PREVIOUS_IMAGE=$(docker inspect --format='{{.Config.Image}}' "$CONTAINER_NAME")
  docker rm -f "$CONTAINER_NAME" >/dev/null
fi

echo "Deploying candidate: $IMAGE"

if ! docker run -d \
  --name "$CONTAINER_NAME" \
  -p "${HOST_PORT}:${CONTAINER_PORT}" \
  --restart unless-stopped \
  "$IMAGE"; then
  echo "ERROR: Candidate container could not start."
else
  for attempt in $(seq 1 15); do
    if curl -fsS --max-time 2 "$HEALTH_URL" >/dev/null 2>&1; then
      echo "DEPLOYMENT SUCCESS: $IMAGE"
      exit 0
    fi
    sleep 2
  done
fi

echo "DEPLOYMENT FAILED: Health check did not pass."
docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true

if [[ -z "$PREVIOUS_IMAGE" ]]; then
  echo "No previous image was recorded. Automatic rollback unavailable."
  exit 1
fi

echo "Rolling back to: $PREVIOUS_IMAGE"
docker run -d \
  --name "$CONTAINER_NAME" \
  -p "${HOST_PORT}:${CONTAINER_PORT}" \
  --restart unless-stopped \
  "$PREVIOUS_IMAGE"

for attempt in $(seq 1 15); do
  if curl -fsS --max-time 2 "$HEALTH_URL" >/dev/null 2>&1; then
    echo "ROLLBACK SUCCESS: $PREVIOUS_IMAGE"
    exit 1
  fi
  sleep 2
done

echo "CRITICAL: Rollback container started but health check failed."
docker logs "$CONTAINER_NAME" || true
exit 2
