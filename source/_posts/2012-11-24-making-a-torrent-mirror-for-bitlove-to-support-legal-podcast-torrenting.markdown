---
layout: post
title: "Making a torrent mirror for bitlove to support legal podcast torrenting"
date: 2012-11-24 17:07
comments: true
categories: [server,ruby,english]
---

[Bitlove](http://www.bitlove.org) is a nice FOSS service, for providing an interface for downloading a lot of podcasts/vodcasts. Having a server which do nothing almost always of the time, I had the idea to mirror some of the torrents. 

Deluge is the most popular server-client for bittorrenting. Installation on Ubuntu/Debian is easy, unfortunatly my Ubuntu 10.03 only included a very old version. So setting up a custom ppa:


```
vim /etc/apt/sources.list

# deb http://ppa.launchpad.net/deluge-team/ppa/ubuntu jaunty main 

apt-get update
apt-get install deluged deluge-console deluge-web
```

start deluged und deluge-web
``` bash
deluged 
# returns, starts the daemon

deluge-web
# stays open
```

Now you can open the UI on your browser: http://host:8112. The default password is "deluge". You can change this under settings. By the way, also change the download directory to something more useful than your home directory. Also increase the number of Active Torrents.

Single torrents can be added via the UI very easily.

## Bulk adding torrents

Now, deluge-console can be used to add torrents from feeds. Without a plugin, deluge cannot understand feeds (There is a plugin, but I did not found good installation instructions).
So I used ruby to filter the feed and add each item to deluge:

```
# maybe have to install ruby nokogiri before
apt-get install rubygems1.9
gem1.9 install nokogiri

curl -k --silent https://bitlove.org/c3d2/ds12/feed |  \
  ruby -e 'require "nokogiri";puts Nokogiri.XML(STDIN).search("enclosure").map{|i|i["url"].gsub("https","http") rescue nil}.compact' |  \
  xargs deluge-console add 
# download the feed, search for xml-nodes enclosure, get url-attribute and
# replace https to http (because deluge can't handle https
```

Done! Now keep watching the grass on the webui :)
Potentially, add a startup script to automatically start deluged and deluge-web:

```
# /etc/init/deluge.conf                                                                                                                                               [root@h2039658]
start on (filesystem and networking) or runlevel [2345]
stop on runlevel [016]

exec /usr/bin/deluged -d -c /home/user/.config/deluge

# /etc/init/deluge-web.conf                                                                                                                                           [root@h2039658]
start on started deluge
stop on stopping deluge

exec /usr/bin/deluge-web -c /home/user/.config/deluge


# usage
start deluge
```


