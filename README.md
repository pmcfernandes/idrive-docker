Docker image for IDrive. 

PREREQUISITES
 - Docker installed
 - Own an account on IDrive.

INSTALLATION
 - Docker compose example:

  idrive:
    container_name: idrive
    image: idrive:latest
    restart: unless-stopped  
    networks:
      - t2_proxy
    volumes:
      - $BACKUPDIR:/home/backup:ro
    environment:
      - TZ=$TZ
      - PGID=$PGID
      - PUID=$PUID

 - $DOCKERDIR points to your local path for idrive config files. Necessary for persist account settings. 
 - $BACKUPDIR points to the local path you need to backup. 

FIRST RUN -> CONFIGURATION
 - Open a bash console into the container.
 - Execute ./idrive --account-setting
   Enter user and password and other stuff.
 - Execute ./idrive --edit-job-sets
   Add to file paths to backup (one path per line and relative to container tree -> /home/backup/xxx)

BACKUP
 - Execute ./idrive --backup
 - For more commands and help open readme.txt file into container

SECOND RUN AND SUCCESSIVES
 - IDrive CRON and dashboard daemon don't persist when you stop and run again the container. 
   It's necessary to execute again ./idrive --account-setting (no need to reconfigure, only restart services). 

TODO
 - Redirect IDrive logs to Docker logs. 
 - Persist cron and dashboard IDrive daemon. I tried with expect commando but no luck. 