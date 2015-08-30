#!/bin/bash
if [ ! -f "/config/www/tt-rss/index.php" ]; then
echo "fetching tt-rss files"
/sbin/setuser abc git clone https://tt-rss.org/git/tt-rss.git /config/www/tt-rss
else
cd /config/www/tt-rss
/sbin/setuser abc git pull origin master
fi
