---
layout: post
title: "Plesk: Cannot change mail passwords through horde"
date: 2012-10-29 15:20
comments: true
categories: [english, server, plesk]
---

After fresh install, the users can't change their passwords in the horde-Webmail client. The (German) message was:

```
Fehler beim Ändern des Passworts für Local Poppassd Server: Verbindungsaufbau abgelehnt

# and the message
# tail /var/log/psa-horde/psa-horde.log
Oct 29 15:00:34 HORDE [error] [imp] FAILED LOGIN for xxx@yyyy.de [127.0.0.1] (forwarded for [xx.xx.xx.xx]) to {127.0.0.1:143 [imap/notls]} [pid 21916 on line 139 of "/usr/share/psa-horde/imp/lib/Auth/imp.php"]

```

**Solution:** 

```bash
/etc/xinetd.d mv /etc/xinetd.d/poppassd_psa.org /etc/xinetd.d/poppassd
/etc/init.d/xinetd restart
```
The poppassd-service has a wrong name and was not started by the xinet-daemon.

(maybe only related to Plesk servers configured with Strato)

(by [http://serversupportforum.de/forum/virtuelle-server/28112-seltsames-problem-mit-strato-vserver-und-xinetd-inkl-l-sung-und-frage.html]())
