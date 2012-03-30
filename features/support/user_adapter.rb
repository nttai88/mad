module UserAdapterHelper

  def user_attribute_helper(name, value)
    case name
    when 'Country'
    when 'State'
      select value, :from => name
    when 'Role'
      choose value
    else
      fill_in name, :with => value
    end
  end
  
  def save_user_helper
    click_button "Save"
  end
  
  def login_helper(username)
    visit new_refinery_user_session_path

    fill_in "Login", :with => username
    fill_in "Password", :with => "123456"

    click_button "Sign in"
  end

  def logout_helper
    click_link "Log out"
  end
end

World(UserAdapterHelper)