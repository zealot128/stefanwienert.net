---
layout: post
title: "Autostart Rails apps with system boot with Ubuntu Upstart and RVM"
date: 2012-10-24 12:43
comments: true
categories: [rails, english]
---

After deploying apps, it is nice to have them automatically started after the boot process of the production system. Using RVM, we came to the following working startup script with the "new" Ubuntu upstart system, which is quite a progress to the hand-tailored init.d-scripts IMO.


```bash
# /etc/init/myapp.conf

description "My App"

start on (net-device-up and local-filesystems)
stop on runlevel [016]
chdir /path/to/app

setuid stefan  # set to the user, which should run the app
exec sudo -u swi  "/path/to/app/start.sh"

respawn
## give up if I respawn 3 times in 60 seconds...
respawn limit 3 60
```
And this startup file (/path/to/app/start.sh) which needs to be executable (chmod +x /path/to/app/start.sh):

```bash
#!/bin/bash
PATH=$PATH:/home/stefan/.rvm/bin
source "/home/stefan/.rvm/scripts/rvm"
source ".rvmrc"  # loading local rvmrc if necessary
# or thin or unicorn start at this point, do NOT start as daemon, upstart handles daemonizing for you
rails s -e production -p 7890
```

Now you can start, restart and stop the app which:
```
sudo start myapp
# stop, restart
```

The logging will be put to ``/var/log/upstart/myapp.log``
