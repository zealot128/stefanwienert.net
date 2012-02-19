---
title: Plesk + Passenger + Rails (+SSL)
date: 2011-09-12 08:54
comments: true
layout: post

categories: [notes, external,ruby,apache,server,plesk]
---
 Um eine Rack-Anwendung mit Plesk zu deployen, gehen wir folgenden Weg:
 Ruby,Rails und Passenger sind installiert. Dazu gibt es allerhand Guides.

* im Plesk eine neue Domain/Subdomain anlegen. Hier braucht man nicht darauf zu achten, PHP oder "Rails FCGI" zu aktivieren
* Unser Rails-Projekt nach /var/www/vhosts/DOMAIN/httpdocs bzw. /var/www/vhosts/DOMAIN/subdomains/SUBDOMAIN/httpdocs kopieren.
* Schauen, dass die Lese/Schreibrechte hinhauen: z.B. ```chgrp psaserv log db tmp -R &&  chmod g+w * -R```

```ruby
bundle install && rake db:migrate RAILS_ENV=production
```
* Im Ordner DOMAIN/conf eine Datei vhost.conf anlegen, mit dem Inhalt:

```apache
DocumentRoot /var/www/vhosts/DOMAIN/httpdocs/public
# bzw.   /var/www/vhosts/DOMAIN/subdomains/SUBDOMAIN/httpdocs/public
<Directory /var/www/vhosts/pludoni.de/subdomains/tasks/httpdocs/public >
  AllowOverride all
  Options -MultiViews
</Directory>
```
* SSL:  die Datei vhost.conf nach vhost_ssl.conf kopieren, um SSL zu aktivieren* Plesk neu laden:

```ruby
/usr/local/psa/admin/sbin/websrvmng -u --vhost-name=DOMAIN
```
* Etwaige Fehler durch Passenger finden

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/1' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
