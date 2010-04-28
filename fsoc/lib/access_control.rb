module AccessControl
  #methods for access control for users, projects etc.

  protected

    #user specific
    def mentor?
      logged_in? and current_user.user_type == "mentor"
    end
      
    def student?
      logged_in? and current_user.user_type == "student"
    end
    
    def admin?
      logged_in? and current_user.user_type == "admin"
    end 
    
    #project specific
    def can_edit_project?(project)
      logged_in? && (current_user == project.proposer || current_user == project.mentor || current_user.user_type == 'admin')
    end
    
    def can_delete_project?(project)
      logged_in? && ((current_user == project.proposer && !project.mentor) || current_user.user_type == 'admin')
    end
    
    #proposal specific
    def can_edit_proposal?(proposal)
      true #TODO
    end
    
    def can_delete_proposal?(proposal)
      true #TODO
    end    

    #Make available as ActionView helper methods.
    def self.included(base)
      if base.respond_to? :helper_method
        base.send :helper_method, :mentor?, :student?, :admin?
        base.send :helper_method, :can_edit_project?, :can_delete_project?
        base.send :helper_method, :can_edit_proposal?, :can_delete_proposal?
      end
    end  
end
