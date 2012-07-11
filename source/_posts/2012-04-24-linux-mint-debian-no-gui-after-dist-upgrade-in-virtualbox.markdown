---
layout: post
title: "Linux Mint Debian - no GUI after dist-upgrade in Virtualbox"
date: 2012-04-24 12:26
comments: true
categories: [linux]
---
I just made a complete upgrade/dist-upgrade of my Linux Mint Debian. After rebooting, I was prompted to shell login tty1 without a GUI/Gnome on tty7 running.

Typing ```sudo xinit``` showed some error messages like:

```
module abi major version doesn't match the server's version
failed to load module vboxvideo
```

I added Virtual Box to the repository list:

```
# /etc/apt/sources.list
deb http://download.virtualbox.org/virtualbox/debian squeeze contrib non-free
```
and reinstalled the guest additions

```
apt-get install virtualbox-guest-x11 virtualbox-guest-additions
```

after rebooting, now the GUI is back.
