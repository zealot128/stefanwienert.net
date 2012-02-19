---
title: Easy ruby Tagcloud calculation and generation script from array
date: 2011-12-16 21:35
comments: true
layout: post

categories: [notes, external, ruby]
---
 Yes I know, tagclouds are deprecated. Nevertheless, sometimes required. To not always start from the beginning for this task, here an idea, how to make a tagcloud with variable formular, given as a block. This script does not generate the cloud by itself, but only calculates weights/sizes. But I also included a full usage example in the Readme.

{% gist 1488047 tagcloud.rb %}


## Usage

Calculate weight of given array. e.g.

```ruby
tags = %w[ruby ruby ruby rails]
Tagcloud.tagcloudize tags do |count,max|
 90 + 110 * ( count / max.to_f)
end
```
results in:

```ruby
[{:text=>"rails", :count=>1, :size=>126}, {:text=>"ruby", :count=>3, :size=>200}]
```

Now, one can use some kind of helper to generate html (not included in this gist, to keep independence), or here directly in haml:

```haml
Tagcloud.tagcloudize(array).each do |e|
  %span{:style => "font-size: #{e[:size]}%"}
    = link_to e[:text], search_path(:q => e[:text])
```

just to make the point, Stuff like this should be put into a helper or partial.

Improvements:

* Instead of direct size calculation, calculate levels for css classes. More prettier :)




---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/36' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
