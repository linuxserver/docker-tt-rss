FROM lsiobase/alpine.nginx:3.5
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install packages
RUN \
 apk add --no-cache \
	curl \
	php7-apcu \
	php7-curl \
	php7-dom \
	php7-gd \
	php7-iconv \
	php7-intl \
	php7-json \
	php7-mcrypt \
	php7-mysqlnd \
	php7-pdo_mysql \
	php7-pdo_pgsql \
	php7-pgsql \
	tar

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80
VOLUME /config
