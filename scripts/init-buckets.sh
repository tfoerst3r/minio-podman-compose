#!/bin/sh
# SPDX-FileCopyrightText: 2026 Thomas Foerster <noreply@tfoerster.de>
#
# SPDX-License-Identifier: MIT
set -e

#=== INPUTS ===#

ACCESS_KEY="${MINIO_ROOT_USER}"
SECRET_KEY="${MINIO_ROOT_PASSWORD}"

MYALIAS=myminio
ENDPOINT="http://minio:9000"
BUCKETS=(
    "raw-data" 
    "curated-data"
    "mlflow-artifacts"
)

#=== MAIN ===#

mc alias set "$MYALIAS" "$ENDPOINT" "$MINIO_ROOT_USER" "$MINIO_ROOT_PASSWORD"

for BUCKET in "${BUCKETS[@]}"; do
    mc mb --ignore-existing "$MYALIAS"/"$BUCKET"
done

mc ls "$MYALIAS"

