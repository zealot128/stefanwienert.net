---
title: Win - using Autohotkey to switch to VM instead
date: 2011-11-20 21:29
comments: true
layout: post

categories: [notes, external, ubuntu]
---
 When using Guake/Yakuake often, one easily tempted to use the key F12 in Windows… and nothing happens!
Now, I am using Autohotkey to open my VM instead – and there I usually have a beautiful yakuake with 256 colors, instead of an ugly cmd or putty.


```ruby
SetTitleMatchMode 1
~F12::

IfWinExist Ubuntu
	WinActivate
return
```

One caveat: Doesn’t seems to work with Firebug, which takes the F12 key by itself. But Firebug offers ways to change keybindings.

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/30' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
