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
      flash[:notice] = 'You are not authorised to add a/another proposal.'
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
    if !can_accept_proposal?(@proposal)
      flash[:notice] = 'Cannot allocate tasks!'
      redirect_to @proposal.project   
    end
    @tasks = @proposal.project.unallocated_tasks
  end
  
  def allocated
    @tasks = Task.find(params[:task_ids])
    @proposal = Proposal.find(params[:id])
    @student = @proposal.student
    @tasks.each do |task|
      due_date = params["task_#{task.id}".to_sym]
      due_date = Date.civil(due_date[:year].to_i, due_date[:month].to_i, due_date[:day].to_i)
      task.update_attributes(:due_date => due_date, :proposal => @proposal)
    end
    @student.proposals.each do |proposal|
      if proposal == @proposal
        status = 'accepted'
        @subject = "Fedora Summer Coding"
        @message = "Congratulations! You have been accepted for the project #{@proposal.project.name}!"
        
        #Sends a mail to the student on acceptance.
        #Remove if not required
        Mail.deliver_message(@student.email, @subject, @message)
      else
        status = 'student_busy'
      end
      proposal.update_attributes(:status => status)
    end
        
    flash[:notice] = 'Project tasks successfully allocated.'
    redirect_to @proposal.project
  end
  
  def reject
    @proposal = Proposal.find(params[:id])  
    @proposal.update_attributes(:status => 'rejected')
    
    @student = @proposal.student
    @subject = "Fedora Summer Coding"
    @message = "We are sorry, we did not accept yor proposal for the project #{@proposal.project.name}!"
        
    #Sends a mail to the student on acceptance.
    #Remove if not required
    Mail.deliver_message(@student.email, @subject, @message)
    
    flash[:notice] = 'Proposal sucessfully rejected.'
    redirect_to @proposal.project
  end  
end
