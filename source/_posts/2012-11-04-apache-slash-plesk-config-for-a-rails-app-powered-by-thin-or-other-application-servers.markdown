---
layout: post
title: "Apache/Plesk config for a Rails app run by Thin"
date: 2012-11-04 00:22
comments: true
categories: [english, rails, plesk, apache]
---

Deploying to a Plesk-managed Apache2 Host, it is a good idea to use multiple application-servers like thin or unicorn, behind a proxy load-balancer. First: totally deactivate every Rails-related feature of Plesk. 

* For Plesk > 10 open: ``/var/www/SUBDOMAIN.DOMAIN/conf/vhost.conf``
* For Plesk < 10 open: ``/var/www/DOMAIN/conf/vhost.conf`` respective ``/var/www/DOMAIN/subdomains/SUBDOMAIN/conf/vhost.conf``

```apache
DocumentRoot /apps/MYAPP/current/public/
<Proxy balancer://myappsservers>
  BalancerMember http://127.0.0.1:9001
  BalancerMember http://127.0.0.1:9002
  BalancerMember http://127.0.0.1:9003
  BalancerMember http://127.0.0.1:9004
</Proxy>
ProxyRequests Off
ProxyBadHeader Ignore
ProxyPreserveHost on
ProxyPass /photos !
ProxyPass /system !
ProxyPass /assets !
ProxyPass / balancer://myappsservers/
ProxyPassReverse / balancer://myappsservers/
<Proxy *>
Order deny,allow
Allow from all
</Proxy>

SetEnv force-proxy-request-1.0 1
SetEnv proxy-nokeepalive 1
SetEnv proxy-initial-not-pooled 1

<IfModule mod_headers.c>
RequestHeader unset Expect early
</IfModule>
```

* Every normal requests go to one of the Thin servers
* Every request to ``/assets/*``, ``/system/*`` and ``/photos/*`` will be handled by Apache2 directly. This is why we have to set the DocumentRoot to the public directory of the Rails app.
* for HTTPS/SSL, which is also handled by Apache, Plesk expects a seperate config file, ``vhost_ssl.conf``. Best is, to symlink the SSL to the non-SSL: 
  ``cd /var/.../conf && ln -s ./vhost.conf ./vhost_ssl.conf``
* do not forget to reload Plesk/apache config: 
  ``/usr/local/psa/admin/bin/websrvmng -a && /etc/init.d/apache2 reload``
* In this example I point to 4 app-servers on Port 9001 through 9004. Apache will load balance the requests. This can be achieved with a ``thin.config.yml`` like that:

```yaml
---
chdir: /apps/MYAPP/current
log: log/thin.log
port: 9001
environment: production
pid: tmp/pids/thin.pid
servers: 4
onebyone: true
wait: 60
timeout: 600
max_persistent_conns: 512
address: 127.0.0.1   
```

Because of the "onebyone"-options we can achieve a restart of the app without downtime. Note that each instance of the app takes some RAM (about 200MB to 300MB for small/medium-sized apps).
We bind the thins to 127.0.0.1, and not to all IP's. That way, nobody can access the thins directly through www.mydomain.com:9001, but only through Apache's proxy.

**FAQ: why thin and not passenger?**
I like thin, because it's easy to use and I can run apps with different Ruby or Gem environments on the same server easily.
