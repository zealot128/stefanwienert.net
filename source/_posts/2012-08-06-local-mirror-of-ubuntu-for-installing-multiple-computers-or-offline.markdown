---
layout: post
title: "Local mirror of Ubuntu for installing multiple computers (or offline)"
date: 2012-08-06 20:17
comments: true
categories: [linux]
---
We needed a usefuel way to install and setup a bunch of ubuntu/debian pc's which are not connected to the internet, yet.  One good solution for that is to set up a local deb-mirror inside the LAN of that computers.

First, download the whole archives (45gigs or something) with debmirror, which is available on apt-get:

```bash
apt-get install debmirror

debmirror ~/REPOSITORY --nosource             \
  --host=ubuntu.mirror.tudos.de --root=ubuntu --dist=precise      \
  --section=multiverse,universe,restricted,main --arch=amd64 --cleanup          \
  --method=rsync
```
  First argument is the target directory, so make sure, it has enough free space. Also notice the ``--dist`` option. The mirror ``ubuntu.mirror.tudos.de`` is a German mirror, you can choose another one [Here](https://launchpad.net/ubuntu/+archivemirrors). You also might want to adjust the architecture, which is here amd64 for 64bit CPU's. If you deploying to 32bit use i386


Then, to install to a offline computer, you have two choices:

1. Copy that files to the offline computer
2. Host that repositories via http or ssh

## Local offline installation

For the first option, copy/rsync the files to the computer/server, e.g. to /REPOSITORY:

```bash
# /etc/apt/sources.list

deb file:/REPOSITORY precise main universe multiverse restricted
```

## Hosted mirror

For a bunch of PC's, a local mirror inside your LAN might be a better solution. So, install apache2 and configure the site to point to the directory, e.g.:

The deb line should like like the following.

```bash
deb http://192.168.0.100/  precise main universe multiverse restricted
```

Please note that you need to generate a repository key, as described [here](http://blogs.cae.tntech.edu/mwr/2007/05/28/my-own-private-debian-repository/), or otherwise the apt-get will fail to to hash sum mismatch.


## Hosted mirror - with ssh

We decided for that solution: similar to http, but the deb line looks like that:


```bash
deb ssh://user@192.168.0.100/home/user/REPOSITORY precise main restricted universe multiverse
```
Exchange ssh-keys with ``ssh-copy-id``/generate identity with ``ssh-keygen`` to that server before.


BTW: after apt-get update you might get warnings about missing archives of i386 (or amd64, if you downloaded the i368 version). Seems, that can be safely ignored.

**Update** There is a (more verbose) guide on [UbuntuUsers (german)](http://wiki.ubuntuusers.de/Ubuntu-Mirror), and a partially relevant guide [here](http://ubuntuforums.org/showthread.php?t=352460)
