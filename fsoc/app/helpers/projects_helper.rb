module ProjectsHelper

  def can_edit_project?(project)
    logged_in? && (current_user == project.proposer || current_user == project.mentor || current_user.user_type == 'admin')
  end
  
  def can_delete_project?(project)
    logged_in? && ((current_user == project.proposer && !project.mentor) || current_user.user_type == 'admin')
  end
end
