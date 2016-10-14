FROM linuxserver/baseimage.apache
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# copy sources.list
COPY sources.list /etc/apt/

# set install packages as variable
ENV APTLIST="git-core php5-apcu php5-gd php5-json php5-mysqlnd php5-pgsql"

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
