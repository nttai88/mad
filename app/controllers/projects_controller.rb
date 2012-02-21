class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.json
  before_filter :login_required, :except => [:recent, :show]
  before_filter :can_create?, :only => [:new, :create]
  before_filter :can_edit?, :only => [:edit, :update, :destroy, :members]
  def index
    if current_user.has_role?("Entrepreneur")
      @projects = current_user.projects
    elsif current_user.is_partner?
      @projects = current_user.partnerable_projects
    else
      @projects = Project.all
    end
  end


  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  def new
    @project = Project.new
    @project.user = current_user
    @project.document ||= Document.new
  end

  # GET /projects/1/edit
  def edit
    @project.document ||= Document.new
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    @project.user_id = current_refinery_user.id
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :ok }
    end
  end
  
  def rate
    @project = Project.find(params[:id])
    @project.rate(params[:stars], current_user, params[:dimension])
  end

  def recent
    @projects = Project.order("created_at DESC").limit 10
    render :action => :index
  end
  protected
  def can_create?
    unless current_user.can_create_project?
      flash[:notice] = "Permission denied."
      redirect_to :action => :index
    end
  end
  def can_edit?
    @project = Project.find(params[:id])
    unless current_user.can_edit_project?(@project)
      flash[:notice] = "Permission denied."
      redirect_to :action => :index
    end
  end
end
