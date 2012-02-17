module Jekyll
  require 'coffee-script'
  class CoffeeScriptConverter < Converter
    safe true
    priority :highest
    pygments_prefix "<notextile>"
    pygments_suffix "</notextile>"

    def matches(ext)
      ext =~ /coffee/i
    end

    def output_ext(ext)
      ".js"
    end

    def post_filter
      ""

    end

    def convert(content)
      begin
        CoffeeScript.compile(content)
      rescue StandardError => e
        puts "CoffeeScript error:" + e.message
      end
    end
  end
end
