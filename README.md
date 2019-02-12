[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Podcast](https://anchor.fm/linuxserverio) - on hiatus. Coming back soon (late 2018).

# PSA: Changes are happening

From August 2018 onwards, Linuxserver are in the midst of switching to a new CI platform which will enable us to build and release multiple architectures under a single repo. To this end, existing images for `arm64` and `armhf` builds are being deprecated. They are replaced by a manifest file in each container which automatically pulls the correct image for your architecture. You'll also be able to pull based on a specific architecture tag.

TLDR: Multi-arch support is changing from multiple repos to one repo per container image.

# [linuxserver/tt-rss](https://github.com/linuxserver/docker-tt-rss)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/tt-rss.svg)](https://microbadger.com/images/linuxserver/tt-rss "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/tt-rss.svg)](https://microbadger.com/images/linuxserver/tt-rss "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/tt-rss.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/tt-rss.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-tt-rss/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-tt-rss/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/tt-rss/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/tt-rss/latest/index.html)

[Tt-rss](https://tt-rss.org) is an open source web-based news feed (RSS/Atom) reader and aggregator, designed to allow you to read news from any location, while feeling as close to a real desktop application as possible.

[![tt-rss](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/tt-rss-banner.png)](https://tt-rss.org)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list). 

Simply pulling `linuxserver/tt-rss` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v6-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=tt-rss \
  -e PUID=1001 \
  -e PGID=1001 \
  -e TZ=Europe/London \
  -p 80:80 \
  -v <path to data>:/config \
  --restart unless-stopped \
  linuxserver/tt-rss
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  tt-rss:
    image: linuxserver/tt-rss
    container_name: tt-rss
    environment:
      - PUID=1001
      - PGID=1001
      - TZ=Europe/London
    volumes:
      - <path to data>:/config
    ports:
      - 80:80
    mem_limit: 4096m
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 80` | WebUI |
| `-e PUID=1001` | for UserID - see below for explanation |
| `-e PGID=1001` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-v /config` | Where tt-rss should store it's config files. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1001` and `PGID=1001`, to find yours use `id user` as below:

```
  $ id username
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```


&nbsp;
## Application Setup

You must create a user and database for tt-rss to use in a mysql/mariadb or postgresql server. In the setup page for database, use the ip address rather than hostname...

A basic nginx configuration file can be found in /config/nginx/site-confs , edit the file to enable ssl (port 443 by default), set servername etc.. Self-signed keys are generated the first time you run the container and can be found in /config/keys , if needed, you can replace them with your own.

The site files are in /config/www/tt-rss , you can find config files and themes folder there. Email and other settings are in the config.php file.



## Support Info

* Shell access whilst the container is running: `docker exec -it tt-rss /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f tt-rss`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' tt-rss`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/tt-rss`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/tt-rss`
* Stop the running container: `docker stop tt-rss`
* Delete the container: `docker rm tt-rss`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start tt-rss`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update the image: `docker-compose pull linuxserver/tt-rss`
* Let compose update containers as necessary: `docker-compose up -d`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **28.01.19:** - Add pipeline logic and multi arch.
* **21.08.18:** - Rebase to alpine linux 3.8.
* **08.01.18:** - Rebase to alpine linux 3.7.
* **19.07.17:** - Use updated [repository](https://git.tt-rss.org/git/tt-rss) for initial install.
* **25.05.17:** - Rebase to alpine linux 3.6.
* **23.02.17:** - Rebase to alpine linux 3.5 and nginx.
* **14.10.16:** - Add version layer information.
* **10.09.16:** - Add layer badges to README.
* **31.08.15:** - Initial Release.
