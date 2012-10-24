---
layout: post
title: "Vim: sane &amp; fast auto completion and common issues"
date: 2012-02-29 17:26
comments: true
categories: [vim, rails, english]
---

Using vim's autocompletion feature is mostly fine, but there are some considerations:

* Problem: using ```foldmethod=syntax``` and completion at the same time leads to **VERY slow completion** in larger files:
  * Solution: Disable folding when in insert mode:
* Problem: completion results are irrelevant/unsatisfying
  * Use ```ctags``` (exuberant-ctags package) to generate all necessary information. Ctags will put a file named ```tags``` in your project's root directory, which include all information about defined functions, classes. For the completion inside a Rails-Project, ctags can also be used to complete all functions from all used gem (also works with RVM). If you are using **supertab**, than choose your standard-completion method with ```:SuperTabHelp``` and set it to "tags".
* Problem: When working in subprojects, none of the functions from the parent-project are completed, e.g. developing Drupal-modules and including Drupal-core tags-file.
  * solution: set a recursive lookup for the 'tags' file
* Problem: Vim does split the keyword by character "-" (or character X whatever). For instances, I'd like vim to see "post-title" as one word in Vim's sense (completion, selection, movements)
  * Solution: ```set iskeyword``` as you like
* Problem: have to type a file-name
  * Solution: use ```Ctrl + X,  Ctrl + F``` to complete filenames, relative to Vim's current workdir. See ```:SuperTabHelp``` for a list of all possible completion options.

Here the related vim-config/vimrc part:
```vim vimrc
  " http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
  autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
  autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

  " ,rt -> regenerate tags, including objects/functions from installed gems
  " http://effectif.com/vim/using-ctags-with-bundler-gems
  map <leader>rt :!ctags --extra=+f --languages=-javascript --exclude=.git --exclude=log -R * `rvm gemdir`/gems/* `rvm gemdir`/bundler/gems/*<CR><C-M>

  " set tags-lookup-path
  set tags=tags;/

  " do not regard "-" as word seperator (css Files!)
  set iskeyword+=-
```
