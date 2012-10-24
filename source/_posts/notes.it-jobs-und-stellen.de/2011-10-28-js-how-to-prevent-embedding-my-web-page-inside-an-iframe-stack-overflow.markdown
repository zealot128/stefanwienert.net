---
title: js - How to prevent embedding my web page inside an iframe? - Stack Overflow
date: 2011-10-28 15:33
comments: true
layout: post

categories: [english, notes, external,javascript]
---


```javascript
if (window.top !== window.self) {
  window.top.location.replace(window.self.location.href);
}
```


---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/25' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
