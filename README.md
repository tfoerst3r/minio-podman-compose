<!--
SPDX-FileCopyrightText: 2026 Thomas Förster <noreply@tfoerster.de>

SPDX-License-Identifier: CC-BY-4.0
-->

<div align='center'>
  <h1>MinIO And Compose</h1>
  <p style='font-size:32pt;'>
  </p>
</div>

<!--============-->

## About the Project 

This project is about remembering how to deploy minIO as a Data Lake.

## Getting Started

> [!WARNING]
> This is not a productive system. The reason why, is that you will find the `secrets/` folder here.
> Your secrets should not be included in the project and the `secrets/` folder needs to be added to `.gitignore`! 
> This is just for demonstration.

### Prerequisites

- podman
- (docker -- may need modifications)

<!--============-->

## Usage

### Starting and access the container infrastructure

In the root folder, you can start up the containers via:

```
podman compose up --detach
```

In order to access environmental variables within the `compose.yml`, a `.env` file/link is needed to the required variables.

Alternatively, you can point directly to the file container the variables:

```bash
podman compose --env-file ./secrets/system.env up --detach
```

To access the container use `podman exec`:

```bash
podman exec -it minio /bin/bash
```

To pull down the composed containers, use:

```bash
podman compose down
```

when you want to remove also the data and configurations, use:

```bash
podman compose down --volumes
```


### Working with MinIO via CLI

`mc` (Minio CLI) is the tool which manages the interaction with MinIO.

**Syntax**

```
mc ARGUMENT [OPTIONS]
```

**Most important ARGUMENTs:**

- `alias` .. manage server credentials in configuration file
- `ls ALIAS[/BUCKET]` .. list buckets or objects
- `mb` .. make a bucket
- `cp` .. copy an object

You can use the `mc` of the container instead of installing your local version. Via `alias` you can set a alias command for `mc` in your current shell session.

```bash
CONTAINER=minio
alias mcli="podman exec $CONTAINER mc"
```

First, you can create an alias for MinIO connection.

```
MYALIAS=xyz
source ./secrets/minio.env && mcli alias set $MYALIAS "http://localhost:9000" $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD
```

Now you can simply use `xyz` to manage the buckets of `xyz`, like listing the content of the connection:

```
mcli ls xyz
```

Or coping a file to the bucket `raw-data`:

```
mcli cp /staging/somefile.txt xyz/raw-data
```

and checking the contents of `raw-data`:

```
mcli ls xyz/raw-data
```

> [!TIP]
> You can also utilize a shell script as given in `script.sh` to automate the process.

### Working with the WebUI

via the URL: `http://localhost:9001` you can access the MinIO via an UI and manage data there as well.

<!--============-->

## License

See `LICENSE.md` for more information.

