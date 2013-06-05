---
layout: post
title: "Rails: Test all your static pages for success and missing translations easily"
date: 2013-06-05 12:59
comments: true
categories: [rails]
---

Testing static pages in Rspec/Rails can be easily done automatically by querying the public methods of the Controller object:

```ruby
describe PagesController do
  render_views
  specify "Browsing static pages" do
    actions = PagesController.public_instance_methods - ApplicationController.public_instance_methods
    actions.each do |action|
      get action
      response.should be_success
      # Bonus points: Check for missing translations
      if response.body.to_s[/translation missing: (.*)"/]
        fail "There are missing translations: #{$1}"
      end
    end
  end
end
```
(As controller, integration or mixed test)

This way, you ensure: Your views compile, no missing translations on the page and the actions are visible to outside world.
