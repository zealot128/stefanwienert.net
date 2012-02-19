---
title: Rails schickt Mails zweimal wenn man sendmail verwendet / Rails sent mails
  twice when using sendmail
date: 2011-11-17 17:07
comments: true
layout: post

categories: [notes, external,rails]
---
 One quite annoying thing, is that rails seems to send mails twice when using sendmail on Debian 5.
 To fix that, add to ```config/environments/production.rb```

```ruby
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.sendmail_settings = {
    :location => '/usr/sbin/sendmail',
    :arguments => "-i"
  }
```


 Notice that arguments is only "-i", default it is "-i -t" which makes sendmail sending again somehow

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/29' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
