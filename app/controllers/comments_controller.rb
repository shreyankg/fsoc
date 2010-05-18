#--
#   Copyright (C) 2010 Gaurav Menghani <gaurav.menghani@gmail.com>
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

class CommentsController < ApplicationController
  before_filter :login_required, :except => 'show'
  
  def index  
    @project = Project.find(params[:project_id])
	@comments = @project.comments
	@comment = Comment.new
	@comment.project = @project
  end

  def new
    @comment = Comment.new
	project = Project.find(params[:project_id])
    @comment.project = project
  end

  def edit
    @comment = Comment.find(params[:id])
	if !can_edit_comment?(@comment)
	  flash[:notice] = 'You are not authorised to edit this comment.'
      redirect_to :action => 'index'
	end
  end
  
  def update
    @task = Comment.find(params[:id])
	if @task.update_attributes(params[:comment])
	  flash[:notice] = 'Comment was successfully updated.'
      redirect_to :action => 'index'
    else
      flash[:notice] = 'Could not update comment'        
      render :action => "edit"
    end
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.author = current_user
	if @comment.save
      flash[:notice] = 'Comment was successfully created.'
	  redirect_to :action => 'index', :project_id => params[:project_id]
    else
	  flash[:notice] = 'Could not create new comment'    
	  redirect_to :action => 'index', :id => @comment.id
    end
  end
  
  def destroy
    #Deleting a comment, actually leaves a message behind
    @comment = Comment.find(params[:id])
	@comment.content = "This message has been deleted."
    if @comment.update_attributes(params[:task])
      flash[:notice] = 'Comment was successfully deleted.'
      redirect_to :action => 'index', :project_id => params[:project_id]
    else
      flash[:notice] = 'Could not delete comment'        
	  redirect_to :action => 'index', :id => @comment.id
    end
  end
end
