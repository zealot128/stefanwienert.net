---
title: formtastic - multiple forms with check boxes leads to double used html id
date: 2011-12-10 16:06
comments: true
layout: post

categories: [notes, external, rails]
---
 Problem: When creating muliple, similar structured forms with formtastic and using check boxes, then all the forms seems to be correlated: Checking a ```check_box``` of the ```check_boxes``` in one form, changes them in another, too. This is because they all used the same id for the check box input.
 One can change this, by using the option ```index => object.id``` in the semantic form for:


```ruby
semantic_form_for user, :index => user.id do |f|
 ....
  f.input :options, :as => :check_boxes
end
```

 In this way, the checkboxes get a prefix of the given index.
This option seems to be undocument, but can be found in the source code ```choice_input_dom_id```.

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/34' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
