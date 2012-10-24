---
layout: post
title: "How to accelerate Rails 3 start up time under Ruby 1.9.3"
date: 2012-07-13 10:01
comments: true
categories: [ruby, rails, english]
---
We use Rails 3 with a boat load of gems, so the basic boot time for any Rake task or Rails Generator is slow... about 1 minute.

Turns out, the basic performance parameters are far from ideal for a big Rails app. As stated at [Reddit](http://www.reddit.com/r/ruby/comments/wgtqj/how_i_spend_my_time_building_rails_apps/c5daer4), there are some tuning parameters. Put this in your bashrc/zshrc and/or ``/etc/profile``:

```bash
export RUBY_HEAP_MIN_SLOTS=800000
export RUBY_HEAP_FREE_MIN=100000
export RUBY_HEAP_SLOTS_INCREMENT=300000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=79000000
```

## Result

```
Before: rake -T  23,05s user 1,39s system 47% cpu 51,545 total
After:  rake -T  6,79s  user 0,98s system 85% cpu 9,124 total
```

We decreased our start-up time by 80%!

Specs: Ruby 1.9.3p194 with Rails 3.2.6 with about 100 gems.

<a href='http://outsmartin.de/'>Thanks outsmartin for finding this piece on Reddit. You are this week's "Hero of Labor" :)</a>

