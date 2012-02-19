---
title: Plesk's qmail does not start after update of kernel
date: 2011-10-25 17:57
comments: true
layout: post

categories: [notes, external]
---
 When reinstalling with apt-get the message:


```bash
qmail update-rc.d: error: expected runlevel [0-9S] (did you forget "." ?)
```

 is shown. Qmail start fails without any message.
 Solution: Restart server to apply new kernel

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/21' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
