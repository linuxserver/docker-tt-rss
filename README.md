[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/tt-rss
[![](https://images.microbadger.com/badges/image/linuxserver/tt-rss.svg)](http://microbadger.com/images/linuxserver/tt-rss "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/tt-rss.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/tt-rss.svg)][hub][![Build Status](http://jenkins.linuxserver.io:8080/buildStatus/icon?job=Dockers/LinuxServer.io/linuxserver-tt-rss)](http://jenkins.linuxserver.io:8080/job/Dockers/job/LinuxServer.io/job/linuxserver-tt-rss/)
[hub]: https://hub.docker.com/r/linuxserver/tt-rss/

[Tiny Tiny RSS][tt-rssurl] is an open source web-based news feed (RSS/Atom) reader and aggregator, designed to allow you to read news from any location, while feeling as close to a real desktop application as possible.


[![tt-rss](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/tt-rss-banner.png)][tt-rssurl]
[tt-rssurl]: https://tt-rss.org/gitlab/fox/tt-rss/wikis/home

## Usage

```
docker create \
--name=tt-rss \
-v /etc/localtime:/etc/localtime:ro \
-v <path to data>:/config \
-e PGID=<gid> -e PUID=<uid> \
-e TZ=<timezone> \
-p 80:80 -p443:443 \
linuxserver/tt-rss
```

**Parameters**

* `-p 80` - webui port *see note below*
* `-v /etc/localtime` for timesync - *optional* *omit if using TZ variable*
* `-v /config` - where tt-rss should store it's config files
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for setting timezone information, eg Europe/London 

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it tt-rss /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application 

You must create a user and database for tt-rss to use in a mysql/mariadb or postgresql server. In the setup page for database, use the ip address rather than hostname...

A basic apache configuration file can be found in /config/apache/site-confs , edit the file to enable ssl (port 443 by default), set servername etc.. Self-signed keys are generated the first time you run the container and can be found in /config/keys , if needed, you can replace them with your own.

The site files are in /config/www/tt-rss , you can find config files and themes folder there. Email and other settings are in the config.php file.

## Updates

* Upgrade to the latest version simply `docker restart tt-rss`.
* To monitor the logs of the container in realtime `docker logs -f tt-rss`.


## Versions

+ **10.09.16:** Add layer badges to README. 
+ **31.08.15:** Initial Release.
