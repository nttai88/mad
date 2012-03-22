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
    end
      
    @projects = (@projects.present? ? @projects : Project).paginate :per_page => PAGINATE_ITEM_COUNT , :page => params[:page]
  end


  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    render :layout => "project"
  end

  def new
    @project = Project.new
    @project.user = current_user
    @project.document ||= Document.new
    @project.save
    redirect_to project_url(@project)
  end

  # GET /projects/1/edit
  def edit
    redirect_to project_url(@project)
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def save
    @project = Project.find(params[:id])
    @project.update_attributes(params[:project])
    render :layout => false
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
    @projects = Project.order("created_at DESC").limit(10).paginate(:page => 1, :per_page => 10)
    render :action => :index
  end

  def remove_attach
    @project = Project.find(params[:id])
    doc = @project.document
    case params[:type]
    when "file"
      doc.remove_file = true
    when "file1"
      doc.remove_file1 = true
    when "file2"
      doc.remove_file2 = true
    when "file3"
      doc.remove_file3 = true
    when "file4"
      doc.remove_file4 = true
    when "file5"
      doc.remove_file5 = true
    when "file6"
      doc.remove_file6 = true
    when "file7"
      doc.remove_file7 = true
    when "file8"
      doc.remove_file8 = true
    when "file9"
      doc.remove_file1 = true
    else
      
    end
    doc.save
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
