---
layout: post
title: "Excel compliant csv export with Rails"
date: 2012-10-16 14:46
comments: true
categories: [rails, english]
---
CSV is a non-standard filetype. Almost every program defines it's own. So does Excel.

Rails always will export and print everything in UTF-8 by default, which is normally a good thing. Unfortunately, even latest Excel versions use LATIN1 (ISO-8859-1), when parsing a CSV-file.

After googling and try-and-error, here is a good, reusable solution. I used Array of Hashes representing the data, but that can be easily replaced by normal models (see [Railscast#362](http://railscasts.com/episodes/362-exporting-csv-and-excel))

```ruby

def MyController < ApplicationController

  def action
    repond_to do |f|
      f.csv do
        data = #...
        hash_to_excel_csv data, "export-liste"
      end
    end
  end

  private
  # This can also be put into a module or ApplicationController

  def hash_to_excel_csv(collection, filename)
    keys = collection.first.keys
    resp = CSV.generate(:col_sep => ";", :force_quotes => true) do |csv|
      csv << keys.map{|i|i.to_s.titleize}
      collection.each do |job|
        csv << job.values
      end
    end

    send_data resp.encode(Encoding::ISO_8859_1, :undef => :replace),
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{filename}.csv"
  end
```
Important aspects:

* semicolon as column seperator
* forced Encoding of Latin1/ISO
* type and disposition, otherwise Rails will make something up (and recode everything to UTF-8...)


*Potential search keywords (which I used) :)*

Ruby render encoding. Render CSV Excel Encoding. ruby csv excel encoding latin1. ruby render force encoding

