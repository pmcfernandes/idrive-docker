# IDrive Docker

Docker image for running [IDrive for Linux](https://www.idrive.com/) in a container.

## Prerequisites

- Docker installed
- An IDrive account

## Building the image

```sh
make          # builds the image as idrive-docker:latest
```

Or manually:

```sh
docker build -t idrive-docker .
```

## Running with Docker Compose

```yaml
services:
  idrive:
    container_name: idrive
    image: pmcfernandes/idrive-docker:latest
    restart: unless-stopped
    networks:
      - t2_proxy
    volumes:
      - $DOCKERDIR:/root/.IDrive   # persists IDrive account/config settings
      - $BACKUPDIR:/home/backup:ro # data to back up (read-only inside container)
    environment:
      - TZ=$TZ
      - PUID=$PUID
      - PGID=$PGID
```

- `$DOCKERDIR` points to your local path for IDrive config files. Necessary to persist account settings across container recreations.
- `$BACKUPDIR` points to the local path you want to back up.
- `$TZ` sets the container timezone (e.g. `Europe/London`).

## Running with the Makefile

```sh
make run     # start the container in the background (mounts / as /backup:ro)
make shell   # open a bash shell into the running container
make kill    # stop and remove the container
```

## First run: configuration

1. Open a bash console into the container (`make shell`, or `docker exec -it idrive-docker /bin/bash`).
2. Execute `./idrive --account-setting` — enter your user, password and other settings.
3. Execute `./idrive --edit-job-sets` — add the file paths to back up, one path per line, relative to the container tree (e.g. `/home/backup/xxx`).

## Backup

- Execute `./idrive --backup`
- For more commands and help, see `readme.txt` inside the container (`/opt/IDriveForLinux/bin`).

## Second run and successive runs

- The IDrive CRON and dashboard daemons do not persist when you stop and restart the container.
- It is necessary to execute `./idrive --account-setting` again — no need to reconfigure, only restart the services.

## TODO

- Redirect IDrive logs to Docker logs.
- Persist the cron and dashboard IDrive daemons (tried with the `expect` command, no luck so far).
