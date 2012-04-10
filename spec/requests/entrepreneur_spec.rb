require "spec_helper"

describe "Entrepreneur" do

  setup_first_user_and_pages

  let(:role) { Refinery::Role.find_by_title("Entrepreneur") }

  describe "sign up" do
    before(:each) do
      visit refinery.root_path
      click_link "Sign up"
    end

    context "with valid data" do
      it "registers user with entrepreneur role" do
        fill_in "Username", :with => "test"
        fill_in "Email", :with => "test@test.com"
        fill_in "Password", :with => "123456"
        fill_in "Password Confirmation", :with => "123456"
        fill_in "First name", :with => "test"
        fill_in "Last name", :with => "tset"

        within ".roles" do
          choose "user_role_ids_#{role.id}"
        end

        click_button "Sign up"

        page.current_path.should eq(refinery.root_path)
      end
    end

    context "with invalid data" do
      it "shows error message" do
        click_button "Sign up"

        within "#errorExplanation" do
          page.should have_content("Email can't be blank")
          page.should have_content("Password can't be blank")
          page.should have_content("Username can't be blank")
          page.should have_content("Username is too short (minimum is 4 characters)")
          page.should have_content("Profile first name can't be blank")
          page.should have_content("Profile last name can't be blank")
        end
      end
    end
  end

  describe "sign in" do
    let!(:user) { FactoryGirl.create(:user) }

    context "when account not confirmed" do
      it "shows message" do
        visit refinery.new_refinery_user_session_path

        fill_in "Login", :with => user.username
        fill_in "Password", :with => "123456"
        click_button "Sign in"

        page.should have_content("You have to confirm your account before continuing.")
      end
    end

    context "when account is confirmed" do
      before { user.confirm! }

      it "signs in user" do
        visit refinery.new_refinery_user_session_path

        fill_in "Login", :with => user.username
        fill_in "Password", :with => "123456"
        click_button "Sign in"

        page.should have_content("Logged in as: #{user.username}")
      end
    end
  end

  describe "create project" do
    let!(:user) {
      user = FactoryGirl.create(:user)
      user.confirm!
      user.roles << Refinery::Role.find_by_title("Entrepreneur")
      user.save
      user
    }
    before :each do
      visit refinery.new_refinery_user_session_path

      fill_in "Login", :with => user.username
      fill_in "Password", :with => "123456"
      click_button "Sign in"
      click_link "Projects"
      click_link "New project"
    end

    it "edit general tab", :js => true do
      page.execute_script("$('#acc .general h3').mouseover();")
      page.find("#acc .general h3 .edit").click
      fill_in "Name", :with => "test project"
      fill_in "Address 1", :with => "123 ABC str"
      page.find("#acc .general h3 .save").click
      page.should have_content("Name: test project")
      page.should have_content("Address 1: 123 ABC str")
    end
    
    it "should show the warning message", :js => true do
      page.execute_script("$('#acc .general h3').mouseover();")
      page.find("#acc .general h3 .edit").click
      fill_in "Name", :with => "test project"
      page.find("#acc .general h3").click
      page.should have_content("Please save or discard your changes to continue")
    end

    
  end
  
end
