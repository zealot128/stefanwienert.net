---
title: Loading google maps v3 asynchronously/dynamically
date: 2011-12-12 17:46
comments: true
layout: post

categories: [notes, external, javascript, ruby]
---
 If you want to load the GoogleMaps from Javascript, instead standard in-head-script-tag, you have to use a callback-function. Otherwise the maps is not loaded completly.


```ruby
if (typeof google == "undefined") {
  jQuery.getScript("http://maps.google.com/maps/api/js?sensor=false&amp;callback=open_google_map")
  // no success callback necessary, google can load our stuff-todo-function
} else {
   // if gmaps already loaded, we can just continue whatever else we want to do
   open_google_map()
}
```

 This above snippet was used, to open up a googlemap in a modal/Lightbox-frame. In this way, GoogleMaps Javascript is only loaded, when the user really wants to see a map

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/35' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
