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

class ProjectsController < ApplicationController
  before_filter :login_required, :except => ['index', 'show']
  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    @proposals = Array.new
    if student?
      @proposals = @project.proposals.find(:all, :conditions => {:student_id => current_user.id})
    end
    if can_view_proposal_list?(@project)
      @proposals = @project.proposals
    end
    @tasks = @project.tasks    
	@comments = @project.comments

	respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    if !can_edit_project?(@project)
      flash[:notice] = 'You are not authorised to edit this project.'
      redirect_to projects_url
    end
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    
    @project.proposer = current_user
    is_mentor = params[:mentor]
    if is_mentor
      @project.mentor = current_user
    end
    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    if !can_delete_project?(@project)
      flash[:notice] = 'You are not authorised to delete this project.'
      redirect_to projects_url
    end
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
  
  def volunteer
    @project = Project.find(params[:id])
    if mentor? && !@project.mentor
      @project.mentor = current_user
      if @project.save
        flash[:notice] = 'You are now mentoring this project.'
      else
        flash[:notice] = 'Unable to process the request'
      end   
    else
      flash[:notice] = 'You cannot volunteer to mentor this project'
    end
    redirect_to(@project)
  end
  
  def resign
    @project = Project.find(params[:id])
    if mentor? && @project.mentor == current_user
      @project.mentor = nil
      if @project.save
        flash[:notice] = 'You are no longer mentoring this project.'
      else
        flash[:notice] = 'Unable to process the request'
      end
    else
      flash[:notice] = 'You cannot resign as mentor from this project'
    end    
    redirect_to(@project)    
  end

end
