module AccessControl
  #methods for access control for users, projects etc.

  protected

    #user specific
    def mentor?(user = current_user)
      logged_in? && user.user_type == "mentor"
    end
      
    def student?(user = current_user)
      logged_in? && user.user_type == "student"
    end
    
    def admin?(user = current_user)
      logged_in? && user.user_type == "admin"
    end 
    
    #project specific
    def can_edit_project?(project)
      logged_in? && (current_user == project.proposer || current_user == project.mentor || current_user.user_type == 'admin')
    end
    
    def can_delete_project?(project)
      logged_in? && ((current_user == project.proposer && !project.mentor) || current_user.user_type == 'admin')
    end
    
    #proposal specific
    def can_add_proposal?(project)
      proposals = Array.new
      if logged_in?
        proposals = project.proposals.find(:all, :conditions => {:student_id => current_user.id})
      end
      student? && proposals.empty?
    end
    
    def can_view_proposal_list?(project)
      (mentor? && project.mentor == current_user) || admin?
    end
        
    def can_edit_proposal?(proposal)
      (student? && proposal.student == current_user) || admin?
    end

    
    def can_view_proposal?(proposal)
      (student? && proposal.student == current_user) || can_view_proposal_list?(proposal.project)
    end
    
    #Make available as ActionView helper methods.
    def self.included(base)
      if base.respond_to? :helper_method
        base.send :helper_method, :mentor?, :student?, :admin?
        base.send :helper_method, :can_edit_project?, :can_delete_project?
        base.send :helper_method, :can_add_proposal?, :can_edit_proposal?, :can_view_proposal_list?
      end
    end  
end
