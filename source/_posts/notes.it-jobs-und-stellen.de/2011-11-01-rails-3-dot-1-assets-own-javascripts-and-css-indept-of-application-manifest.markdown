---
title: ! 'Rails 3.1 Assets: Own javascripts and css independent of application manifest'
date: 2011-11-01 10:39
comments: true
layout: post

categories: [notes, external]
---
 Sometimes, one want to use seperate stylesheets or javascript independent of the asset-manifest, e.g. to only include specific js on some pages. Working well in development, turns out in production the files are not compiled and provided (404 Error).
 To fix this, include the files explicitly in ```config/application.rb``` or ```config/environments/production.rb``` like this:


```ruby
 config.assets.precompile += ["jquery.tablescroll.js", "markitup/jquery.markitup.js",
      "textile.css.scss"]
```


---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/26' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
