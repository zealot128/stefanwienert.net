---
title: Installing vim 7.3 and gvim on Ubuntu/Debian
date: 2011-10-10 04:43
comments: true
layout: post

categories: [english, notes, external, vim, linux]
---
Always comes in handy...
This builds Vim with most features, including ruby-support.


```bash
sudo apt-get install libncurses-dev libgnome2-dev \
 libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev \
 libx11-dev libxpm-dev libxt-dev ruby-dev

cd /usr/local/src
sudo su
wget ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2
tar jxf vim-7.3.tar.bz2
cd vim73/
./configure --with-features=huge --enable-gui=gnome2 --enable-rubyinterp
make
make install
```


---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/10' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
