#!/usr/bin/env bash
#set -euo pipefail

# Secrets
source secrets/system.env
source secrets/minio.env

ACCESS_KEY="${MINIO_ROOT_USER}"
SECRET_KEY="${MINIO_ROOT_PASSWORD}"

# Input
CONTAINER=minio
ENDPOINT="http://localhost:${API_PORT}"
BUCKET="my-bucket"
FILE="/staging/somefile.txt"

# Script
podman exec "$CONTAINER" mc alias set local "$ENDPOINT" "$ACCESS_KEY" "$SECRET_KEY"
podman exec "$CONTAINER" mc mb --ignore-existing "local/$BUCKET"
podman exec "$CONTAINER" mc cp "$FILE" "local/$BUCKET/"
podman exec "$CONTAINER" mc ls "local/$BUCKET"

