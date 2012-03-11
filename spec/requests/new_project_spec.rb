require "spec_helper"

describe "Create new project" do

  setup_first_user_and_pages
  login_user

  let!(:user) do
    user = Refinery::User.first
    user.profile.first_name = "mad"
    user.profile.last_name = "lab"
    user.profile.about = "about nothing ..."
    user.profile.contact_attributes = { :address1 => "nowhere", :address2 => "somewhere",
      :city => "out of space", :zip => "123456", :url => "http://google.com",
      :phone => "987654321" }
    user.save!
    user
  end

  describe "'Use your profiles existing contact-info' checkbox" do
    it "allows to copy/remove user info in form", :js => true do
      visit new_project_path

      page.execute_script("$('#acc .general h3').mouseover();")
      page.find("#acc .general h3 .edit").click
      # populate fields
      check "use_existing"

      find_field("project_name").value.should eq(user.full_name)
      find_field("project_contact_attributes_address1").value.should eq(user.profile.contact.address1)
      find_field("project_contact_attributes_address2").value.should eq(user.profile.contact.address2)
      find_field("project_contact_attributes_city").value.should eq(user.profile.contact.city)
      find_field("project_contact_attributes_zip").value.should eq(user.profile.contact.zip)
      find_field("project_contact_attributes_phone").value.should eq(user.profile.contact.phone)
      find_field("project_contact_attributes_about").value.should eq(user.profile.about)

      # clear fields
      uncheck "use_existing"

      find_field("project_name").value.should be_blank
      find_field("project_contact_attributes_address1").value.should be_blank
      find_field("project_contact_attributes_address2").value.should be_blank
      find_field("project_contact_attributes_city").value.should be_blank
      find_field("project_contact_attributes_zip").value.should be_blank
      find_field("project_contact_attributes_phone").value.should be_blank
      find_field("project_contact_attributes_about").value.should be_blank

    end
  end

end
