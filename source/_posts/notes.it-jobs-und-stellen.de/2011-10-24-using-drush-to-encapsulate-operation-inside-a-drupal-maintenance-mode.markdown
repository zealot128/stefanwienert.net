---
title: Using Drush to encapsulate operation inside a drupal maintenance mode
date: 2011-10-24 18:22
comments: true
layout: post

categories: [english, notes, external,drupal]
---
 Using drush is a convenient way to deploy bigger DB-changes without giving the users a glitch. Instead they will see a maintenance mode page.

```bash
drush vset site_offline 1
cat ~/db.sql | mysql -u usr_bla -p db_bla
drush vset site_offline 0
```



---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/17' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
