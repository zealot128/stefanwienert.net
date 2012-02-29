---
title: Hyphenation via css now works!
date: 2012-02-21 21:39
comments: true
layout: post

categories: [notes, external,css]
---

Finally, justify aligning now makes much more sense.
Just add the ```hyphens: auto``` to your ```<p>```'s. Also, do not forget all the vendor-specific tags and adding a ```lang='de'/en/...``` tag to your body/html tag.
Works with IE 10, Chrome 13+, Firefox 6+ and Safari 5.1+ (see [MDN](https://developer.mozilla.org/en/CSS/hyphens))

If you are using SASS/SCSS (you do, right?), here the mixin code:

```scss
@mixin hyphens($value: "manual") {
  @each $prefix in -webkit-, -moz-, -o-, "" {
    #{$prefix}hyphens: $value;
  }
}
// using with:
p, li {
  text-align: justify;
  @include hyphens(auto);
}

```

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/44' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
