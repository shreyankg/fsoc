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

class ProposalsController < ApplicationController
  before_filter :login_required
  
  def show
    @proposal = Proposal.find(params[:id])
    if !can_view_proposal?(@proposal)
      flash[:notice] = 'You are not authorised to access this proposal.'
      redirect_to(Project.find(params[:project_id]))
    end    
  end

  def new
    project = Project.find(params[:project_id])
    if can_add_proposal?(project)
      @proposal = Proposal.new
      @proposal.project = project
    else
      if student?
        flash[:notice] = 'You are not allowed to submit more than one proposal.'
      else
        flash[:notice] = 'You are not allowed to submit proposals.'
      end
      redirect_to(project)
    end
  end

  def edit
    @proposal = Proposal.find(params[:id])
    if !can_edit_proposal?(@proposal)
      flash[:notice] = 'You are not authorised to edit this proposal.'
      redirect_to(Project.find(params[:project_id]))
    end
  end

  def create

    @proposal = Proposal.new(params[:proposal])
    if @proposal.save
      flash[:notice] = 'Your proposal was successfully created.'
      redirect_to :action => 'show', :id => @proposal.id
    else
      flash[:notice] = 'Could not create your proposal'    
      render :action => "new"
    end
  
  end

  def update
    @proposal = Proposal.find(params[:id])

    if @proposal.update_attributes(params[:proposal])
      flash[:notice] = 'Your proposal was successfully updated.'
      redirect_to :project_proposal
    else
      flash[:notice] = 'Could not update your proposal'        
      render :action => "edit"
    end
  end

  def destroy
    @proposal = Proposal.find(params[:id])
    if !can_edit_proposal?(@proposal)
      flash[:notice] = 'You are not authorised to delete this proposal.'
      redirect_to project_proposals_url
    end
    @proposal.destroy
    flash[:notice] = 'Project proposal deleted!'
    redirect_to project_path(@proposal.project)
  end
  
  def allocate
    @proposal = Proposal.find(params[:id])
    @tasks = @proposal.project.unallocated_tasks
  end
  
  def allocated
    @tasks = Task.find(params[:task_ids])
    #student_id = params[:student_id]
    @proposal = Proposal.find(params[:id])
    @tasks.each do |task|
      end_date = params["task_#{task.id}".to_sym]
      end_date = Date.civil(end_date[:year].to_i, end_date[:month].to_i, end_date[:day].to_i)
      task.update_attributes(:end_date => end_date, :proposal => @proposal)
    end
    @proposal.update_attributes(:accepted => true)
    flash[:notice] = 'Project tasks successfully allocated.'
    redirect_to @proposal.project
  end
end
