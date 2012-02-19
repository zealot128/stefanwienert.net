---
title: Rails Mountable Engine - Useful starting point with rspec, factory girl and
  friends
date: 2012-02-15 15:03
comments: true
layout: post

categories: [notes, external, rails]
---
 Since Ruby on Rails 3.1, engines were introduced. Unfortunatly, the generated code needs some love. I copied together some settings from various Stackoverflow posts regarding this topic.
<h2>Creating new engine</h2>


```bash
rails plugin new my_engine -T --mountable --dummy-path=spec/dummy
```

 Creates a mountable (seperated) engine without test:unit.
 Now we can add some useful gems to ```my_engine.gemspec```:


```ruby
# let's bundler take care of our file list
  s.files        = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.add_dependency "rails", "~> 3.2"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "shoulda-matchers", "~>1.0"#, "~> 3.0"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "database_cleaner"
  # s.add_development_dependency "geminabox"
  # if you are using your own gem server, take geminabox
end
```

### Configuring Rspec
 Adding also the spec_helper-File for RSpec to work with our dummy app.


```ruby
# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
require "factory_girl_rails"
require "database_cleaner"
require 'shoulda/matchers/integrations/rspec'

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = false
    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end
    config.before(:each) do
      DatabaseCleaner.start
    end
    config.after(:each) do
      DatabaseCleaner.clean
    end
end
```

## Testing
 Now we can use "bundle exec rspec" to run our tests from within the dummy app. Later, when we want to do integration with our real app, we should start by adding our gem to the app’s Gemfile via file-path.  Doing so, we are able to work at our engine and viewing the results right in our development app (see later in this article).

## Working

 Engines are IMO a very great idea. The engine’s directory structure is very similiar to a Rails dir structure. So placing all our stuff in the right place, will automatically load that files, e.g.:

* ```my_engine/config/locales/en.yml```
* Custom I18n strings
* ```my_engine/app/controllers/models/my_engine/model1.rb```
* ```my_engine/db/migrate/123123123_migration1.rb```
* ```my_engine/app/assets/stylesheets/my_engine.css.scs```
  * This stylesheet can be included in our real App with ```require my_engine``` inside the application.css manifest
* ...etc.

### Namespacing everything
 It is a good idea, to namespace the models, controllers etc. So make sure, the lib/feedmaker/engine.rb includes the isolated namespace:


```ruby
module MyEngine
  class Engine < ::Rails::Engine
    isolate_namespace MyEngine
  end
end
```

 Also, the models can be put into the same namespace, to avoid name collisions in the app later on.


```ruby
# app/models/my_engine/model1.rb
class MyEngine::Model1< ActiveRecord::Base
```
* Namespace the controller in the same way, putting everything under ```app/controllers/my_engine```.
* Same for views, which are located under ```app/views/my_engine/...```

### Routes
 Add routes to ```config/routes``` in this way:


```ruby
MyEngine::Engine.routes.draw do
  resources "feeds"
  root to: "feeds#index"
end
```

 Due to our isolation, this resource will look for an ```feeds_controller``` inside the
 ```my_engine``` namespace.

## Using the engine

 Adding the gem to the Gemfile


```ruby
# real applications Gemfile
#gem "my_engine"  # production
#gem "my_engine" ,path: '~/repos/my_engine'   # development
```
* Copy over the migrations with
```ruby
rake my_engine:install:migrations
```
  and migrate.
* Add assets to the manifest files, if required
* Mount the engine to a specific URL:

```ruby
# config/routes.rb
mount MyEngine::Engine => "/engine"
```
* This will map the "/engine" url to the root-path from MyEngine.
* Every other resource is also located under this namespace, e.g. the feeds_controller from above can be reached from "/engine/feeds"

## Pitfalls

* The engine routes and url-helper are automatically namespaced to our engine’s namespaces, due to the ```isolated Engine``` directive. So do not use ```my_engine_model1_path```, but ```model1_path``` in the engine’s views and controller.
* An isolated mountable app normally render’s it own’s layout file (e.g. active admin has a own admin template). If you want to render from the Main-app’s template, change the ```app/controllers/my_engine/application_controller.rb```, to inherit from the main app’s controller:

```ruby
class MyEngine::ApplicationController < ApplicationController
```
* If you are in the situation, that you use url-helpers in the app’s layout (or included partials), than you will get an error, that these helpers can not be found. Prefix the helper’s call with ```my_app``` -> ```link_to my_app.search_path```


## Conclusion
 Looks a little bit messy, but after some setup everything works very nicely. Engines should be used, if there is a clearly distinguishable part of the app, which is independent from the rest. e.g. provision of assets, CMS-related features.

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/43' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
