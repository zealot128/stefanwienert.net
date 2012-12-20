---
layout: post
title: "Howto test (action) caching in Rails with Rspec"
date: 2012-10-14 13:36
comments: true
categories: [rails, Rspec, english]
---

Sooner or later, every Web-App will need caching. Rails has some good support with different caching strategies, but no way to test it OOTB. But when the generation of custom paths and cache conditions gets more complicated, the desire to test that behavior raises.


Fortunatly, using Rspec tags, this is very easy (inspired by this [Gist](https://gist.github.com/2267519)):

```ruby
# spec/spec_helper.rb

RSpec.configure do |config|
  # ...
  config.around(:each, :caching => true) do |example|
    caching, ActionController::Base.perform_caching = ActionController::Base.perform_caching, true
    store, ActionController::Base.cache_store = ActionController::Base.cache_store, :memory_store
    silence_warnings { Object.const_set "RAILS_CACHE", ActionController::Base.cache_store }

    example.run

    silence_warnings { Object.const_set "RAILS_CACHE", store }
    ActionController::Base.cache_store = store
    ActionController::Base.perform_caching = caching
  end
end
```

Now, we can tag individual scenarios with enabled caching:

```ruby
it "should cache", caching: true do
  load "app/controllers/user_controller.rb"

  User.should_receive(:all).and_return([])
  get :index

  # mock only get called once == caching works!
  get :index

  #  or can be tested, if key is available:
  ActionController::Base.cache_store.exist?("views/my_custom_cache_path").should be_true
end
```

With **Action-Caching**, we need to reload our controller in the test, otherwise caching won't work.
You can test the behavior by either instantiate some mocks here and there or by checking the existence of the cache key.

