---
title: Plesk + PHP - Activate Error Reporting
date: 2011-10-04 16:16
comments: true
layout: post

categories: [notes, external, plesk,php]
---
 In plesk in comination for PHP, the error reporting is redirected to a log file, and instead a Whitescreen is shown. To change that, e.g. for a development-system:


```bash
cd /var/www/vhosts/DOMAIN/subdomains/SUBDOMAIN
touch conf/vhost.conf
echo "php_admin_flag display_errors on
php_admin_value error_reporting 2047" >> conf/vhost.conf
/usr/local/psa/admin/sbin/websrvmng -u --vhost-name=DOMAIN
```

 Applies for domains and subdomains as well.

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/9' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
