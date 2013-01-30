---
layout: post
title: "Practical Ruby: Acquiring QNAP NAS Usage stats"
date: 2013-01-10 10:46
comments: true
categories: [ruby, english]
---

The network storage systems of QNAP (like TS-4XX) have a logging function, which can be enabled via the interface. Then, every file access is logged to a SQLite database, located in ``/mnt/HDA_ROOT/.logs/conn.log`` on the NAS filesystem (only accessible via SSH).

Using a part of Ruby on Rails, ActiveRecord, to query data, makes this very convenient and short in code:

```ruby
# model.rb
raise "NeedRuby1.9.3" if RUBY_VERSION < "1.9.3"
require "sqlite3"
require "active_record"

class QLog < ActiveRecord::Base
  self.table_name = "NASLOG_CONN"
  self.primary_key = "conn_id"

  # all read on real files
  scope :read, -> { where("conn_action = 2 and conn_res != '---'") }

  def self.from_user(name)
    where(conn_user: name)
  end
end

# "nas" is here a SSH-Alias for the ... you guess NAS
`scp nas:/mnt/HDA_ROOT/.logs/conn.log /tmp/conn.log`
ActiveRecord::Base.establish_connection adapter: "sqlite3",
  :database => "/tmp/conn.log"
```

Now, this file can be loaded into an IRB/Pry session to play with the data, e.g.:

* *Printing the last 5 open files:*
```ruby
puts QLog.read[-5..-1].map{|i|i["conn_res"]}
```
* *Showing, which user accessed how many files:*
```ruby
puts QLog.read.group(:conn_user).count
```
* *Showing the top 10 popular files:*
```ruby
puts QLog.read.group(:conn_res).order("count_all desc").limit(10).count
```
* *Top 10 popular files of a specific user:*
```ruby
puts QLog.from_user("someguest").read.group(:conn_res).order("count_all desc").limit(10).count
```

and so on.



