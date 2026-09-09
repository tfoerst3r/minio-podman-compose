#!/usr/bin/env bash
set -e

# Secrets
source secrets/system.env
source secrets/minio.env

ACCESS_KEY="${MINIO_ROOT_USER}"
SECRET_KEY="${MINIO_ROOT_PASSWORD}"

# Input
CONTAINER=minio
ENDPOINT="http://localhost:${API_PORT}"
ALIAS="xyz"

# Script
podman exec "$CONTAINER" mc alias set "$ALIAS" "$ENDPOINT" "$ACCESS_KEY" "$SECRET_KEY"

