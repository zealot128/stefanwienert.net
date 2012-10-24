---
title: Mysterious double POST Requests in Rails 3.1 with ActiveAdmin
date: 2011-12-03 22:55
comments: true
layout: post

categories: [english, notes, external, rails]
---
 Make sure to change application.js to not require the whole tree, because the activeadmin jquery files will get loaded. This will mess up your normal behaviour, especially because they will not have a CSRF Token.

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/32' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
