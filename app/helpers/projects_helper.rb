module ProjectsHelper
  def full_access?(project)
    if current_user
      return true if current_user.can_edit_project?(project)
      return true if current_user.advisor_of?(project) || current_user.partner_of?(project)
    end
    return false
  end

  def formated_user_data(user)
    contact = Contact.where(:contactable_type => "Profile",
                            :contactable_id => user.profile.id).first || Contact.new

    { :full_name => user.full_name, :zip => contact.zip, :city => contact.city,
      :phone => contact.phone, :address1 => contact.address1, :address2 => contact.address2,
      :about => user.profile.about, :url => contact.url }.to_json
  end
end
