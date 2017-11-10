###############################################################################
## Docker file to build ddeno/xu4-debian-tinydns image
##     - Will create image that runs tinydns as its service
##     - Read project README.md for configuring the image for your needs
###############################################################################

# Import resin/odroid-xu4-debian base image (Debian Jessie)
FROM ddeno/xu4-debian-base

MAINTAINER Drake Deno 

# Update repository sources list and distribution
RUN apt-get update && apt-get upgrade

# CONSIDER MOVING ALL OF THIS TO A .sh FILE
# CAN USE CP <local git file> to <container location>
# THEN RUN <git file in container>

# Add required tools
RUN apt-get install build-essential automake pkg-config

# Clone our tinydns Git project
RUN cd /root && git clone http://github.com/pjps/ndjbdns

# Generate our configure file
RUN cd /root/ndjbdns && mv README.md README && aclocal && autoconf && automake --add-missing

# Configure the ndjbdns project
RUN cd /root/ndjbdns && ./configure --prefix=/usr/local --sysconfdir=/etc

# Build ndjbdns
RUN cd /root/ndjbdns && make && make install

# Copy systemd services and sockets
# RUN cp /usr/local/lib/systemd/system/*.service /lib/systemd/system/ 
# RUN cp /usr/local/lib/systemd/system/*.socket /lib/systemd/system/ 

# Inform systemd about new services
# RUN systemctl daemon-reload

# Setup our log files

# Restart rsyslog

# Now time to configure

# Now since we are configured, start
# VOLUME /var/log/dnscache.log:/var/log/dnscache.log
# VOLUME /var/log/tinydns.log:/var/log/tinydns.log our service script to run in containter
