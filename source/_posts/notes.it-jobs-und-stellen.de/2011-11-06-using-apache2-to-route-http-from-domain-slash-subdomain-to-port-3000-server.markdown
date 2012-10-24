---
title: Using Apache2 to route http from domain/subdomain to port 3000 server
date: 2011-11-06 19:42
comments: true
layout: post

categories: [english, notes, external,apache,ruby]
---
 To easy test Rails Application-Server (mongrel, webrick, thin) in development through a full domain/subdomain, you can use the Apache-Proxy-Ability. So, every traffic will be redirected transparently to that running application server.


```bash
a2enmod proxy
a2enmod proxy_balancer
a2enmod proxy_http
```

## Plesk-specific apache vhost.conf/vhost_ssl.conf


```apache
DocumentRoot /home/stefan/repos/empfehlungsbund/public
<Proxy balancer://thinservers>
  BalancerMember http://127.0.0.1:3000
</Proxy>

ProxyPreserveHost On
#ProxyPass /assets !
ProxyPass / balancer://thinservers/
ProxyPassReverse / balancer://thinservers/

<Proxy *>
Order deny,allow
Allow from all
</Proxy>
```
 (vhost_ssl.conf is identical)

 Reload Plesk-Config and restart apache2:

```bash
/usr/local/psa/admin/bin/websrvmng -a
/etc/init.d/apache2 restart
```

 Now, we only have to start our dev-Server on port 3000, and done!
This is useful for developing/testing facebook, that requires a SSL-domain.

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/28' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
