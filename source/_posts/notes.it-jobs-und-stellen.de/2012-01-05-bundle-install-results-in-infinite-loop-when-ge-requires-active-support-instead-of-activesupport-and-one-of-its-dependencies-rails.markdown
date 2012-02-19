---
title: bundle install results in infinite loop when ge requires active_support instead
  of activesupport and one of its dependencies rails
date: 2012-01-05 15:17
comments: true
layout: post

categories: [notes, external, ruby]
---
 bundle install results in infinite loop when gem requires active_support and one of its dependencies rails.


```ruby
s.add_runtime_dependency "active_support"
# change to:
s.add_runtime_dependency "activesupport"
```


---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/38' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
