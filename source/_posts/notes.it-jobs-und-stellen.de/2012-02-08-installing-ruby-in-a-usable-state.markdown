---
title: Installing Ruby (in a usable state)
date: 2012-02-08 22:08
comments: true
layout: post

categories: [notes, external, ruby]
---
 Here are some thoughts on how to install Ruby with rvm and most features on a Debian/Ubuntu plattform:
 <!-- more -->


```bash
apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core \
   zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 \
   libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake \
   libtool bison subversion

bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)

rvm install 1.9.3
rvm use 1.9.3 --default
rvm use @global   #using global gemset, which all gemsets inherit
gem install bundler pry awesome_print nokogiri thin capistrano guard \
    rspec rb-inotify guard-rspec spork
# tmuxinator is also very nice if you are using tmux as a collab tool
```

 We also install RVM and compile the latest 1.9.3 branch and setting it to our shell’s default. Aftwards I install some gems which i need in almost every project.

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/41' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
