FROM linuxserver/baseimage.apache

MAINTAINER Mark Burford <sparklyballs@gmail.com>

# set install packages as variable
ENV APTLIST="git-core \
php5-apcu \
php5-gd \
php5-json \
php5-mysql \
php5-pgsql"

# install packages
RUN apt-get update && \
apt-get install \
$APTLIST -qy && \

# cleanup 
apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add some files 
ADD cron/ /etc/cron.d/
ADD defaults/ /defaults/
ADD init/ /etc/my_init.d/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh && \

# cron permissions fix 
chmod 755 -v  /etc/cron.d/tt-rss

# expose ports
EXPOSE 80 443

# set volumes
VOLUME /config
