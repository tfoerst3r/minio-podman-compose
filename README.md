<!--
SPDX-FileCopyrightText: 2026 Thomas Förster <noreply@tfoerster.de>

SPDX-License-Identifier: CC-BY-4.0
-->

<div align='center'>
  <h1>MinIO And Compose</h1>
  <p style='font-size:32pt;'>
  </p>
</div>

## About the Project 

This project is about remembering how to deploy minIO as a Data Lake.

## Getting Started

> [!WARNING]
> This is not a productive system. The reason why, is that you will find the `secrets/` folder here.
> Your secrets should not be included in the project and the `secrets/` folder needs to be added to `.gitignore`! 
> This is just for demonstration.

### Prerequisites

- podman
- docker (may need modifications)

## Usage

> ### Starting and access the container infrastructure
> 
> Inside that directory, start the container in the background. 
> Unfortunately `system.env` need to be added to make sure the global variables are read beforehand:
> 
> ```bash
> podman compose --env-file ./secrets/system.env up --detach
> ```
> 
> Alternatively, you can make a soft-link to `ln -s ./secrets/system.env .env`. 
> The root file `.env` will be read.
> 
> To access the container use `podman exec`:
> 
> ```bash
> podman exec -it $(podman ps -q -f name=minio) /bin/bash
> ```

<!-- ---- -->

> ### Create and Managinge a Bucket
> The following script `script.sh` creates a bucket "my-bucket" and copies a file "somefile.txt" from `./staging/`
> to the bucket.
> 
> ```bash
> #!/usr/bin/env bash
> #set -euo pipefail
> 
> # Secrets
> source secrets/system.env
> source secrets/minio.env
> 
> ACCESS_KEY="${MINIO_ROOT_USER}"
> SECRET_KEY="${MINIO_ROOT_PASSWORD}"
> 
> # Input
> CONTAINER=minio
> ENDPOINT="http://localhost:${API_PORT}"
> BUCKET="my-bucket"
> FILE="/staging/somefile.txt"
> 
> # Script
> podman exec "$CONTAINER" mc alias set local "$ENDPOINT" "$ACCESS_KEY" "$SECRET_KEY"
> podman exec "$CONTAINER" mc mb --ignore-existing "local/$BUCKET"
> podman exec "$CONTAINER" mc cp "$FILE" "local/$BUCKET/"
> podman exec "$CONTAINER" mc ls "local/$BUCKET"
> ```
> 
> - `mc alias` .. manage server credentials in configuration file
> - `mc mb` .. make a bucket
> - `mc cp` .. copy object
> - `mc ls` .. list buckets and objects

## License

See `LICENSE.md` for more information.

