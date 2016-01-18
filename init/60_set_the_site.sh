#!/bin/bash

[[ ! -d /config/www/tt-rss/.git ]] && (echo "fetching tt-rss files, this may take a little while" && \
git clone https://tt-rss.org/git/tt-rss.git /config/www/tt-rss && chown -R abc:abc /config/www)

# opt out for autoupdates
[ "$ADVANCED_DISABLEUPDATES" ] && exit 0

cd /config/www/tt-rss
git pull origin master
chown -R abc:abc /config/www

