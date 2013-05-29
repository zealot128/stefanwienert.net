---
layout: post
title: "rails.vim new feature - custom gem projections for faster navigation - resque"
date: 2013-05-29 22:43
comments: true
categories: [vim, rails, english]
---

Recently, a new version of the Rails.vim plugin for .. well Vim.. was released. That added flexible so called projections, which are custom file openings, templates etc. This week, [thoughtbot](http://robots.thoughtbot.com/post/50107717967/extending-rails-vim-with-custom-commands) published an article, how to leverage that feature.

Here, I show some of my recent added projections for some Gems that we use:

{% gist 5673683 %}

this provides:

* custom services in app/services,
* Active-Admin files in app/admin with relationship to the corresponding model, as well as a basic template, when creating new admin files with ``:Radmin foobar!``
* Cells with method-to-view navigation via ``:R``, similar to controller-view
* draper and carrierwave specific files, copied from [https://gist.github.com/jsteiner/5556217](https://gist.github.com/jsteiner/5556217) but sorted into the r:rails_gem_projections. This way, this navigations commands are only active, when that gems are listed in the current bundle
* Resque basic worker
* ``:Rconfig`` files
* all spec/support as ``Rsupport``

Feel free, to modify my examples and share your own snippets!
