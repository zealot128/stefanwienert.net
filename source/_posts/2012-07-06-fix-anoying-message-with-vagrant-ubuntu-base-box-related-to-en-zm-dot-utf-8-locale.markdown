---
layout: post
title: "Fix anoying message with vagrant ubuntu base box related to en_ZM.UTF-8 locale"
date: 2012-07-06 00:44
comments: true
categories: [vagrant, server, linux]
---

I just initialized a new Vagrant "base" virtualbox and got the following messages after ssh-login and after most commands:

```
-bash: warning: setlocale: LC_ALL: cannot change locale (de_DE.UTF-8)
```

If I tried to rebuild the locales I got another error message related to missing translation for Zambia:

```
$ locale-gen
/bin/bash: warning: setlocale: LC_ALL: cannot change locale (de_DE.UTF-8)
Generating locales...
  en_AG.UTF-8... up-to-date
  en_AU.UTF-8... up-to-date
  en_BW.UTF-8... up-to-date
  en_CA.UTF-8... up-to-date
  en_DK.UTF-8... up-to-date
  en_GB.UTF-8... up-to-date
  en_HK.UTF-8... up-to-date
  en_IE.UTF-8... up-to-date
  en_IN.UTF-8... up-to-date
  en_NG.UTF-8... up-to-date
  en_NZ.UTF-8... up-to-date
  en_PH.UTF-8... up-to-date
  en_SG.UTF-8... up-to-date
  en_US.ISO-8859-1... up-to-date
  en_US.UTF-8... up-to-date
  en_ZA.UTF-8... up-to-date
  en_ZM.UTF-8... cannot open locale definition file `en_ZM': No such file or directory
failed
  en_ZW.UTF-8... up-to-date
Generation complete.
```

To fix this, just run as vagrant user:

```bash
export LC_ALL="de_DE.UTF-8"
sudo locale-gen de_DE.UTF-8
```

(Maybe problem also exists with other locales besides German)
