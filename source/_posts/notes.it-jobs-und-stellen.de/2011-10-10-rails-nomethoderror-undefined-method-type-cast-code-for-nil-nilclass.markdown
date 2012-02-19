---
title: ! 'Rails: NoMethodError (undefined method `type_cast_code'' for nil:NilClass)'
date: 2011-10-10 11:43
comments: true
layout: post

categories: [notes, external,rails]
---
This Error:

```ruby
NoMethodError (undefined method `type_cast_code’ for nil:NilClass):
  occured in activerecord-3.1.1/lib/active_record/attribute_methods/read.rb
```

* Reason: tried to use a created_at column, that is nil
* Solution: remove t.timestamps from table migration

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/11' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
