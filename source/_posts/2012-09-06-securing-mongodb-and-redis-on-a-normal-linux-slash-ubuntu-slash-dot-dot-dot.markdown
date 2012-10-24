---
layout: post
title: "Securing mongodb and redis on a normal linux/ubuntu/..."
date: 2012-09-06 15:38
comments: true
categories: [linux,server, english]
---
If you are using Redis-Server or MongoDB, they are usually not protected. So anybody can connect from anywhere to your Key-Value-Stores and to nasty stuff.

Use linux firewall iptables to drop all packets, which are not from your application/webserver/localhost:

```bash
# Run in a shell for each service
port="6379" # REDIS Port: 6379
#port="27017" # MONGO Port: 27017
server="servername.de"
iptables -A INPUT -s $servername.de -p tcp -m tcp --dport $port -j ACCEPT
iptables -A INPUT -s localhost -p tcp -m tcp --dport $port -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport $port -j DROP

# Control your Rules with iptables -L
```

Add more ACCEPT rules above the DROP rules if you have more application servers which need to connect to the mongo/redis/whatever.

Do not forget to save the rules, otherwise they are cleaned after a reboot

```bash
iptables-save
```
