---
layout: post
title: "Proxy Errors with unicorn and apache2 reverse proxy"
date: 2012-05-22 23:14
comments: true
categories:  [ruby,apache,english]
---

I usually used thin as app-server for Rails in combination with Apache2 as webserver. I tried using unicorn instead, because I read a lot of interesting articles about it. Unfortunatly, now I got a lot of error messages like that when uploading files:

```
[Tue May 22 22:56:31 2012] [error] [client 146.52.xx.xx] proxy: Error reading from remote server returned by /photos/upload, referer: http://pics.stefanwienert.de/
[Tue May 22 22:58:49 2012] [error] (103)Software caused connection abort: proxy: pass request body failed to 127.0.0.1:9001 (127.0.0.1)
[Tue May 22 22:58:49 2012] [error] proxy: pass request body failed to 127.0.0.1:9001 (127.0.0.1) from 146.52.xx.xx ()
[Tue May 22 22:59:01 2012] [error] proxy: client 146.52.xx.xx given Content-Length did not match number of body bytes read
```

Switching back to thin and the following config works fine:

``` yaml
---
chdir: /apps/pics/prod/current
log: log/thin.log
port: 9001
environment: production
pid: tmp/pids/thin.pid
servers: 4
onebyone: true
wait: 60
timeout: 600
max_persistent_conns: 512
```
Important is the timeout of 10minutes here, to complete large uploads of pictures. For reference, this is my apache vhost conf:

``` apache
DocumentRoot /apps/pics/prod/current/public

<Proxy balancer://unicornservers>
BalancerMember http://127.0.0.1:9001
BalancerMember http://127.0.0.1:9002
BalancerMember http://127.0.0.1:9003
BalancerMember http://127.0.0.1:9004
</Proxy>
ProxyRequests Off
ProxyBadHeader Ignore

ProxyPass / balancer://unicornservers/
ProxyPassReverse / balancer://unicornservers/
ProxyPreserveHost on
ProxyPass /photos/large !
ProxyPass /photos/original !

ProxyPass /photos/thumb !
<Proxy *>
Order deny,allow
Allow from all
</Proxy>

AllowEncodedSlashes on

SetEnv force-proxy-request-1.0 1
SetEnv proxy-nokeepalive 1
SetEnv proxy-initial-not-pooled 1
```
I found the last environment settings in some post about apache proxy problems.

Maybe someone with the same problem can take this as a starting point to fix this kind of problem with unicorn. I switch back to thin, which is fine.
