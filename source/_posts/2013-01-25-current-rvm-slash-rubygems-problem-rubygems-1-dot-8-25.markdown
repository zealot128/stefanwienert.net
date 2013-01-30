---
layout: post
title: "current rvm/rubygems problem: Rubygems 1.8.25"
date: 2013-01-25 15:40
comments: true
categories: [ruby]
---
I just wanted to install newest Ruby via RVM, but got this error:

```
ruby-1.9.3-p374 - #configuring
ruby-1.9.3-p374 - #compiling
ruby-1.9.3-p374 - #installing
Retrieving rubygems-1.8.25
There is no checksum for 'http://production.cf.rubygems.org/rubygems/rubygems-1.8.25.tgz' or 'rubygems-1.8.25.tgz', it's not possible to validate it.
If you wish to continue with unverified download add '--verify-downloads 1' after the command.
```

Even rerun with ``--verify-downloads 1`` didn't work, because http://production.cf.rubygems.org/rubygems/rubygems-1.8.25.tgz is simply down. Until this mirror has the version supplied, one can use:

```bash
rvm_rubygems_version=1.8.24 rvm install ruby
# or
rvm_rubygems_version=1.8.24 rvm reinstall ruby-1.9.3-p374
```


Found on twitter:
<blockquote class="twitter-tweet"><p>@<a href="https://twitter.com/wonbyte">wonbyte</a> just got easier suggestion: "rvm_rubygems_version=1.8.24 rvm install ruby"</p>&mdash; Michal Papis (@mpapis) <a href="https://twitter.com/mpapis/status/294810001334210561">January 25, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
