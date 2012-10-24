---
title: Apache2 - transparent proxy to another Server domain/subdomain
date: 2011-12-05 11:53
comments: true
layout: post

categories: [english, notes, external, server]
---
 Aim: Typing notes.pludoni.de in browser shows the same page as notes.it-jobs-und-stellen.de.


```apache
ProxyVia full
#ProxyPreserveHost On
#ProxyPass /assets
ProxyPass / http://notes.it-jobs-und-stellen.de/
ProxyPassReverse / http://notes.it-jobs-und-stellen.de/

<Proxy *>
Order deny,allow
Allow from all
</Proxy>
```

 e.g. this Blog is hosted unter notes.it-jobs-und-stellen.de but should be reachable as notes.pludoni.de. The problem was the option ```ProxyPreserveHost```, which sent the domain notes.pludoni.de to the it-jobs-und-stellen.de-Server. The result was that this server delivered a wrong content, because he do not know anything about "notes.pludoni.de" (resulted in Plesk default page).

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/33' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
