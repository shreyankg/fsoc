# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def highlighted
    return 'class="current_page_item"'
  end
  
  def devide_link(links)
    if links
      out = []
      links.split(',').each do |link|
        out << link_to(link, link) + '<br >'
      end
      out
    else
      '-'
    end
  end
  
  def dash(obj)
    if obj.nil? or obj == ""
      "-"
    elsif obj.respond_to?("each")
      sum = ""
      obj.each do |o|
        if o.nil? or o == ""
          return "-"
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
  
  def mentor?
    logged_in? and current_user.user_type == "mentor"
  end
    
  def student?
    logged_in? and current_user.user_type == "student"
  end
  
  def admin?
    logged_in? and current_user.user_type == "admin"
  end  
end
