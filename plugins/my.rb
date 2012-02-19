
# deactivate ruby pants, WTF??
module OctopressFilters
  def post_filter(input)
    input
  end
end

module Jekyll
   module Filters
    def category_links(categories)
      dir = @context.registers[:site].config['category_dir']
      categories = categories.sort!.map do |item|
        "<a class='category' href='/#{dir}/#{item.gsub(/_|\P{Word}/, '-').gsub(/-{2,}/, '-').downcase}/'>#{item}</a>"
      end

      case categories.length
      when 0
        ""
      when 1
        categories[0].to_s
      else
        "#{categories.join(" ")}"
      end
    end
   end
end
