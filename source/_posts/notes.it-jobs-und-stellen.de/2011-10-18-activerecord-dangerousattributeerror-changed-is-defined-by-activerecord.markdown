---
title: ! 'ActiveRecord DangerousAttributeError: changed? is defined by ActiveRecord'
date: 2011-10-18 10:51
comments: true
layout: post

categories: [english, notes, external, rails]
---
```
ActiveRecord::DangerousAttributeError: changed?
```

 Columns named ```changed``` or ```valid``` causes this exception.
 To change that:


```ruby
class Node < ActiveRecord::Base
  def self.instance_method_already_implemented?(method_name)
    return true if method_name == 'changed'
    return true if method_name == 'changed?'
    super
  end

end
```

 But note, that this will influence the functionality of ActiveRecord (without changed? the API can’t distinguish, if the model was changed or is valid etc.).

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/15' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
