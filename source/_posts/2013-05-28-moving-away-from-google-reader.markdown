---
layout: post
title: "Moving away from Google Reader"
date: 2013-05-28 21:35
comments: true
categories: [feed, server]
---

In may, Google [announced](http://googlereader.blogspot.de/) that they will shut down their Google Reader Service on July 1st. Surprised and a little bit sad after reading this, I tried out several alternative solutions for feed reading and aggregation. Most of the proclaimed applications are hosted SaaS. For me, after this experience with the Google Reader service, I would not rely on a 3rd party hoster again.
So the best solution that I found, is to install [Tiny Tiny RSS](http://tt-rss.org/redmine/projects/tt-rss/wiki) on my server, which even supports PostgreSQL as datastore besides MySQL. One download, install, integration into cronjob, I could import my OPML file exported from Greader into TTRSS.

Internet is full of elaborate instructions on how to install TTRSS, e.g. that German guide on [Linux und ich](http://linuxundich.de/de/ubuntu/update-auf-tiny-tiny-rss-1-7-9-ermoglicht-installation-auf-shared-webspace/).

After using TTRSS 2 months, my conclusion:

* much faster Web-UI compared with the sluggish Google Reader
* refresh interval of feeds is easy to control, because the cronjob is controlled by me. On Greader, I found that some of my more specialized feeds were not refresh very often, so I got "news" sometimes several hours or half-days later after published.
* TT-RSS has a function which can send me an E-Mail once per day, with all unread posts. I configured this Mail to be sent on midnight. All news, that I didn't read on that day, will be included into the mail. This way, my unread list stays very short and I have a clean slate every morning.
* Multi-user support (which I do not use, yet)

Besides, I can star news items that will show up [in this RSS-Feed:](http://f.stefanwienert.de/public.php?op=rss&id=-1&key=3e064d9acac316bcd152eb9d2f161e2986726190).
Later, I will include that feed into my new [online activity stream](/stream).

As any solution, TT-RSS has some disadvantages. For me, I missed:

* the available (android) apps are not very great. I want an app that can download news, which I can read off-line later.
* Some other systems have a computer-aided rating algorithm (NewsBlur), which sort news on how interesting they might be for you. They do that on a content analysis or social media activity basis. For some, very frequent feeds, like general news feeds or Heise magazine, this kind of feature would be really nice.

From every bad thing, there are usually some good things happen. With the death of Google reader, the market is free and innovation can happen. So far, several 3rd party reader providers and OpenSource products are shown up. If you are interested in keeping reading feeds, here are some links:

* [Ask HN: Have you settled on a Google Reader replacement?](https://news.ycombinator.com/item?id=5750057)
* [Readerpocalypse - The Alternatives](http://www.russellbeattie.com/blog/readerpocalypse-the-players)
* [Newsblur](http://www.newsblur.com/) (paid service)
* [Stringer](https://github.com/swanson/stringer) (free self hosted minimalistic)
* [Owncloud News](http://algorithmsforthekitchen.com/blog/?p=479)
* Prismatic and Flipboard
* much much more.


