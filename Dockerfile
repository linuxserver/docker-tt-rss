FROM linuxserver/baseimage.apache

MAINTAINER Sparklyballs <sparklyballs@linuxserver.io>

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
ADD defaults/ /defaults/
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/ 
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

# expose ports
EXPOSE 80 443

# set volumes
VOLUME /config
