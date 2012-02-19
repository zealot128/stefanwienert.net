---
title: Verzögerungsbenachrichtigung für Parallels Plesk Panel-Key-Update - Server
  Support Forum
date: 2011-09-16 05:56
comments: true
layout: post

categories: [notes, external,plesk]
---
 Plesk kann nicht updaten, da es ein Problem mit CURL und SSL gibt (Debian 5).
Lösung:


```bash
echo -e '#!/bin/sh\n\n/usr/bin/curl --sslv3 $@'  >/usr/local/bin/psacurl
chmod 755 /usr/local/bin/psacurl
echo -e "alias curl='/usr/local/bin/psacurl'" > /opt/psa/admin/.profile
```


---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/2' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
