---
title: Easy XML-Sitemap with Rails
date: 2011-12-16 22:08
comments: true
layout: post

categories: [notes, external, rails]
---
 Rails is too custom, to provide a generic sitemap as a gem for any situation. But it ist not too hard anyway! Here is a frame how to make one:


```ruby
rails g controller sitemap
```

add the index action to sitemap-controller:


```ruby
class SitemapController < ApplicationController
  def index
    respond_to do |f|
      f.xml
    end
  end
end
```

 add the route (bonus points for restricting the format to xml)


```ruby
# config/routes
  ....
  get "sitemap", :controller => :sitemap, :action => :index
```

 Generate the sitemap with builder:

```ruby
# app/views/sitemap/index.xml.builder
xml.instruct!
xml.urlset(:xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9",
           "xmlns:xsi"=> "http://www.w3.org/2001/XMLSchema-instance",
            "xsi:schemaLocation"=>"http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd") do
  # whatever logic your app has, e.g. static pages:
  @pages.each do |page|
    xml.url do
      xml.loc page_url(page)
      xml.lastmod page.updated_at.to_date.to_s(:db)
      xml.changefreq "monthly"
      xml.priority 0.3
    end
  end
end
```


 Do not forget to add the sitemap to your robots.txt


```ruby
Sitemap: http://www.mydomain.de/sitemap.xml
```


---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/37' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
