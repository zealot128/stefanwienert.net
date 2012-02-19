---
title: Adventures with bundler rvm capistrano
date: 2011-10-12 05:29
comments: true
layout: post

categories: [notes, external,ruby]
---
 When using capistrano, we ran into several issues:
## Bundler git old repos


```ruby
 [err :: localhost] fatal: Could not parse object 22e2458b77519e8eb8463170c1a1fe4bab105f3e.
 [out :: localhost] Git error: command git reset --hard 22e2458b77519e8eb8463170c1a1fe4bab105f3e in directory /var/www/vhosts/xxxx/httpdocs/shared/bundle/ruby/1.9.1/bundler/gems/compass-22e2458b7751 has failed.
  [out :: localhost] If this error persists you could try removing the cache directory /var/www/vhosts/xxxx/httpdocs/shared/bundle/ruby/1.9.1/cache/bundler/git/compass-dcbe0c41f22c777e90babfa80d61f78dfdea41b2
```

 we had some git-linked bundle gems in the Gemfile. Turns out, one of the linked branches (compass with rails31 branch) no longer exists.
<h2>Shared Folder incomplete</h2>
 The generated shared-Folder of capistrano missed two subfolders:

```ruby
mkdir shared/log
mkdir shared/system  # or whatever you need for paperclip
```



---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/12' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
