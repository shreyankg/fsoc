# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def highlighted
    return 'class="current_page_item"'
  end
  
  def devide_link(links)
    if links
      out = []
      links.split(',').each do |link|
        out << link_to(link, link, :popup=> true) + '<br >'
      end
      out
    else
      '-'
    end
  end
  
  def dash(obj, replacement='-')
    if obj.nil? or obj == ""
      replacement
    elsif obj.respond_to?("each")
      sum = ""
      obj.each do |o|
        if o.nil? or o == ""
          return replacement
        else
          sum += o
        end
      end
      sum
    else
      obj
    end
  end
  
  def all_projects
    return Project.all.reverse
  end
  

end
