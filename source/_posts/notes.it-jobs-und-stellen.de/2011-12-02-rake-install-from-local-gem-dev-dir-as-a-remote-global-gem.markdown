---
title: ! 'Rake: Install from local Gem-Dev-Dir as a remote global gem'
date: 2011-12-02 14:46
comments: true
layout: post

categories: [english, notes, external, ruby]
---
 For installing and updating a (private) gem that was developed locally, we defined a rake task.


```ruby
def run(cmd)
  puts "CMD: #{cmd}"
  `#{cmd}`
end

desc "Install Gem auf pludoni Server"
task :install_remote => :build do
  file = `ls -t pkg/ |head -n 1`.gsub("\n"," ")
  server = ENV['SERVER'] || "root@pludoni.de"

  run "scp pkg/#{file} #{server}:/tmp/#{file}"
  run "ssh #{server} 'gem install -l /tmp/#{file}'"
end
```

Useful, if you develop private gems that are not gonna be published at rubyforge, because they are very company/app-specific. Gem-in-a-box is very easy to install and provides a nice way to distribute personal gems.

---
<i>Reposted from <a href='http://notes.it-jobs-und-stellen.de/notes/31' rel='canonical'>notes.it-jobs-und-stellen.de</a></i>
