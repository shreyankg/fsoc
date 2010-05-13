#--
#   Copyright (C) 2010 Shreyank Gupta <sgupta@REDHAT.COM>
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU Affero General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU Affero General Public License for more details.
#
#   You should have received a copy of the GNU Affero General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++

module AccessControl
  #methods for access control for users, projects etc.

  protected

    #user specific
    def mentor?(user = current_user)
      if user == current_user
        logged_in? && user.user_type == "mentor"
      else
        user.user_type == "mentor"
      end
    end
      
    def student?(user = current_user)
      if user == current_user
        logged_in? && user.user_type == "student"
      else
        user.user_type == "student"
      end
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
      (student? && proposal.student == current_user && proposal.status == 'pending') || admin?
    end

    def can_view_proposal?(proposal)
      (student? && proposal.student == current_user) || can_view_proposal_list?(proposal.project)
    end
    
    def can_view_user_proposal_list?(user)
      user == current_user || admin? || mentor?
    end
    
    def can_accept_proposal?(proposal)
      mentor? && proposal.project.mentor == current_user && !proposal.project.unallocated_tasks.empty?
    end
    
    #task specific
    def can_add_task?(project)
      can_edit_project?(project)
    end
    
    def can_view_task_list?(project)
      true
    end
        
    def can_edit_task?(task)
      can_edit_project?(task.project) && task.author == current_user
    end

    
    def can_view_task?(task)
      true
    end
    
    #Make available as ActionView helper methods.
    def self.included(base)
      if base.respond_to? :helper_method
        base.send :helper_method, :mentor?, :student?, :admin?
        base.send :helper_method, :can_edit_project?, :can_delete_project?
        base.send :helper_method, :can_add_proposal?, :can_edit_proposal?, :can_view_proposal_list?, :can_view_user_proposal_list?
        base.send :helper_method, :can_accept_proposal?
        base.send :helper_method, :can_add_task?, :can_edit_task?, :can_view_task_list?
      end
    end  
end
