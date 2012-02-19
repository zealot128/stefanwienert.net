---
title: ! 'spree ecommerce: setting default locale to German and stuff'
date: 2012-01-10 11:43
comments: true
layout: post

categories: [notes, external, rails]
---
 Spree is a fantastic eCommerce Rails-Engine. To change it, to speak German, one has to:


```ruby
# Gemfile

# original repository not compatible at the moment, use fork
#gem 'spree_i18n', :git => 'git://github.com/spree/spree_i18n.git'
gem 'spree_i18n', :git => 'git://github.com/kares/spree_i18n.git'

# sh
bundle
rake spree_i18n:update_default
rake spree_i18n:sync
wget https://github.com/svenfuchs/rails-i18n/raw/master/rails/locale/de.yml -O config/locales/rails_de.yml

# config/initializers/spree.rb
if Spree::Config.instance
  Spree::Config.set(:default_locale => 'de')
end
```

 this should get you started

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/39' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
