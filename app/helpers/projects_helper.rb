module ProjectsHelper
  def full_access?(project)
    if current_user
      return true if current_user.can_edit_project?(project)
      return true if current_user.advisor_of?(project) || current_user.partner_of?(project)
    end
    return false
  end
end
