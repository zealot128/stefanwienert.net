---
title: ! 'Ruby: Find all special chars in String (umlauts etc)'
date: 2011-10-26 10:45
comments: true
layout: post

categories: [english, notes, external,ruby]
---


```ruby
>> text = "Grüße"
>> text.each_char.select{|i| i.bytesize != i.chars.count}.uniq
=> ["ü", "ß"]
```


---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/22' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
