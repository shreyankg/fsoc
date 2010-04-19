# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def highlighted
    return 'class="current_page_item"'
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
end
