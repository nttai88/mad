class CommentsController < ApplicationController
  before_filter :authenticate_refinery_user!
  
  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.new(params[:comment])
    @comment.user_id = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @project, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { redirect_to(@project, :alert => 'Comment could not be saved. Please fill in all fields') }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
end