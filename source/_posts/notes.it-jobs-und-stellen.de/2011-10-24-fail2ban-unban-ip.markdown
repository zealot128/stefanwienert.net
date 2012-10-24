---
title: fail2ban - unban ip
date: 2011-10-24 18:57
comments: true
layout: post

categories: [english, notes, external,server]
---
Sometimes, due to testing, fail2ban blocks an IP from me. To unblock me (and not wait 10 minutes):


```bash
iptables -L fail2ban-ssh -v --line-numbers
iptables -D fail2ban-ssh <LINE-NUMBER-OF-DROP-RULE>
```


---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/18' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
