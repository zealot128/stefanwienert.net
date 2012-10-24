---
layout: post
title: "Wget and downloading from Sourceforge..."
date: 2012-07-18 17:57
comments: true
categories: [linux, server, english]
---
Hands up, who tried to download a source code archive directly from Sourceforge's "Direct link" (Or any other PHP download script)?

Wget will download it, but save the file as the Link's name, e.g.:

```bash
wget "http://downloads.sourceforge.net/project/tmux/tmux/tmux-1.6/tmux-1.6.tar.gz?r=&ts=1342626938&use_mirror=ignum"
# ->
tmux-1.6.tar.gz?r=&ts=1342626938&use_mirror=ignum
```

Ugly. Using ``-O tmux.tar.gz``? Tedious.


## Solution
Turns out, with a small option (``--trust-server-name``), wget will name the file correctly ("tmux-1.6.tar.gz").
Once and for all, create a file **~/.wgetrc**:

**Update** For some php-script, using the content-disposition header, works too (e.g. vim.org download scripts)

```bash
trust_server_names = on
content-disposition = on
```

(Found [ here ](http://www.system-fuchs.de/2011/12/wget-sourceforge-co/))
