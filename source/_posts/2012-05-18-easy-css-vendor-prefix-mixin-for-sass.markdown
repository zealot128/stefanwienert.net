---
layout: post
title: "Easy css vendor prefix mixin for SASS"
date: 2012-05-18 12:26
comments: true
categories: [css,english]
---

With Sass, one of the aspiring preprocessors for CSS, one can easily automate menial tasks with mixins (user defined functions for css). For example, one common task ist to define one css-attribute in all vendor-specific prefixes (-moz, -webkit, -o, -ms) until that feature becomes css standard.

Besides the common known border-radius, box-shadow etc. there is the really pretty *hyphens*, which allows browsers to hyphenate words, which makes justified alignment much more useful. This can easily be covered by a general Sass-mixin:

```sass
= vendor-prefix($name, $argument)
  #{$name}: $argument
  -webkit-#{$name}: $argument
  -ms-#{$name}: $argument
  -moz-#{$name}: $argument
  -o-#{$name}: $argument

//Calling  with
p
  +vendor-prefix(hyphens, auto)
```

or in scss
```scss
@mixin vendor-prefix($name, $argument) {
  #{$name}: $argument;
  -webkit-#{$name}: $argument;
  -ms-#{$name}: $argument;
  -moz-#{$name}: $argument;
  -o-#{$name}: $argument;
}
p {
  @include vendor-prefix(hyphens, auto)
}
```

