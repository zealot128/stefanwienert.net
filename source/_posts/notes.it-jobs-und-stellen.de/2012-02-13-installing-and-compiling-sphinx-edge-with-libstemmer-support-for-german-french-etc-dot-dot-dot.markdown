---
title: Installing and compiling Sphinx edge with Libstemmer support for German, French,
  etc....
date: 2012-02-13 16:46
comments: true
layout: post

categories: [notes, external, rails, sphinx]
---
Using and installing the Sphinx Search Daemon with a wide range of stemmer, not only English
<!-- more -->

```bash
cd mysrc
wget http://sphinxsearch.com/files/sphinx-2.0.3-release.tar.gz
tar xf sphinx-2.0.3-release.tar.gz
cd sphinx-2.0.3-release/
cd libstemmer_c/
wget http://snowball.tartarus.org/dist/libstemmer_c.tgz
tar xf libstemmer_c.tgz
mv libstemmer_c/* . -f
cd ..
./configure --with-libstemmer
make
sudo make install
```


Then, the stemming can be activated for:
 danish          dutch           english         finnish          french          german        hungarian     italian         norwegian   portuguese       romanian         russian          spanish         swedish        turkish

In your sphinx.conf or config/sphinx.yml (thinking sphinx, the great Rails gem for managing Sphinx, sphinx.yml) set the new stemmers:

```ruby
# sphinx.conf
morphology = libstemmer_de, stem_en

# or sphinx.yml
morphology: libstemmer_de, stem_en
```


So, more than one stemmer can be activated.

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/42' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
