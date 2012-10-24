---
title: ! 'LaTex: Switch from article to report/book - replacing section with chapter'
date: 2011-09-23 14:49
comments: true
layout: post

categories: [english, notes, external,bash,latex]
---
 To quickly change from a Article doc-class to a Book or Report class, one have to replace all section with chapters and so on.
 Using sed helps:


```bash
find | grep tex$ | xargs sed -i 's/\\section{/\\chapter{/'
find | grep tex$ | xargs sed -i 's/subsection/section/'
```


---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/5' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
