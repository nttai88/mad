class MembersController < ProjectsController
  before_filter :login_required
  before_filter :can_edit?

  def index
    @partners = @project.partners.includes(:profile)
    @advisors = @project.advisors.includes(:profile)
  end
  
  def create
    unless params[:partner_id].blank?
      member = User.find params[:partner_id]
      if member
        pu = ProjectsUser.find_or_create_by_project_id_and_user_id(@project.id, member.id)
        pu.user_type = ProjectsUser::PARTNER
        pu.save
      end
    end
    unless params[:advisor_id].blank?
      member = User.find params[:advisor_id]
      if member
        pu = ProjectsUser.find_or_create_by_project_id_and_user_id(@project.id, member.id)
        pu.user_type = ProjectsUser::ADVISOR
        pu.save
      end
    end
    redirect_to :action => :index
  end

  def remove
    pu = ProjectsUser.find_by_project_id_and_user_id(params[:project_id], params[:id])
    pu.destroy
    redirect_to :action => :index
  end
  
  protected
  def can_edit?
    @project = Project.find(params[:project_id])
    unless current_user.can_edit_project?(@project)
      flash[:notice] = "Permission denied."
      redirect_to :action => :index
    end
  end
end