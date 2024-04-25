FROM ubuntu:latest

RUN mkdir -p /home/backup

WORKDIR /work

# Copy entrypoint script
COPY entrypoint.sh .
RUN chmod a+x entrypoint.sh

# Install packages
# iproute2 for /bin/ip, which is used to find/generate a unique host ID
RUN apt-get update && apt-get -y install nano wget curl iproute2 python3

# Download idriveforlinux package
RUN wget https://www.idrivedownloads.com/downloads/linux/download-for-linux/linux-bin/idriveforlinux.bin -P /work
RUN chmod a+x /work/idriveforlinux.bin

# Timezone (no prompt)
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN echo "Europe/London" > /etc/timezone
RUN rm -f /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata

# Create the log file to be able to run tail
RUN touch /var/log/idrive.log

# Run the command on container startup
ENTRYPOINT ["/work/entrypoint.sh"]