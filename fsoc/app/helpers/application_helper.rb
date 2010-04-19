# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def highlighted
    return 'class="current_page_item"'
  end
  
  def all_projects
    return Project.all.reverse
  end
  
end
