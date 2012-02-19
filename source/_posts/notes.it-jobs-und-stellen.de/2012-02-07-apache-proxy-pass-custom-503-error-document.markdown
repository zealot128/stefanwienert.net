---
title: Apache Proxy Pass -> Custom 503 Error Document
date: 2012-02-07 11:53
comments: true
layout: post

categories: [notes, external]
---
 When the underlying server is not reachable, Apache generates an ugly 503 Status message. To change that and inform the users that our server will be up soon again (due to a deployment):
 Vhost/http conf


```apache
DocumentRoot /home/stefan/repos/empfehlungsbund/public
ProxyPreserveHost On

# if you running in production, maybe handling the assets by apache self, instead
# of thin/unicorn etc.
# ProxyPass /assets !


# Here the interesting lines:
ProxyPass /error-documents !
ErrorDocument 503 /error-documents/503.html
Alias /error-documents /home/stefan/repos/empfehlungsbund/public

# BTW: apache does not allow encoded slashes in URL,
# it will always generate 404. We used base64 encoded urls, which included this problem,
# to fix:
AllowEncodedSlashes on
```


---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/40' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
