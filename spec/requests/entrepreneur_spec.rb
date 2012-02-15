require "spec_helper"

describe "Entrepreneur" do

  setup_first_user_and_pages

  let(:role) { Refinery::Role.find_by_title("Entrepreneur") }

  describe "sign up" do
    before(:each) do
      visit root_path
      click_link "Sign up"
    end

    context "with valid data" do
      it "registers user with entrepreneur role" do
        fill_in "Username", :with => "test"
        fill_in "Email", :with => "test@test.com"
        fill_in "Password", :with => "123456"
        fill_in "Password confirmation", :with => "123456"
        fill_in "First name", :with => "test"
        fill_in "Last name", :with => "tset"

        within ".roles" do
          choose "user_role_ids_#{role.id}"
        end

        click_button "Sign up"

        page.current_path.should eq(root_path)
      end
    end

    context "with invalid data" do
      it "shows error message" do
        click_button "Sign up"

        within "#errorExplanation" do
          page.should have_content("Email can't be blank")
          page.should have_content("Password can't be blank")
          page.should have_content("Username can't be blank")
          page.should have_content("Username is too short (minimum is 3 characters)")
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
        visit new_refinery_user_session_path

        fill_in "Login", :with => user.username
        fill_in "Password", :with => "123456"
        click_button "Sign in"

        page.should have_content("You have to confirm your account before continuing.")
      end
    end

    context "when account is confirmed" do
      before { user.confirm! }

      it "signs in user" do
        visit new_refinery_user_session_path

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
      visit new_refinery_user_session_path

      fill_in "Login", :with => user.username
      fill_in "Password", :with => "123456"
      click_button "Sign in"
      click_link "Projects"
      click_link "New project"
      page.current_path.should eq("/projects/new")
    end

    it "should be unsuccessful" do
      fill_in "Name", :with => "test_project"
      click_button "Save"
      page.should have_content("Title can't be blank")
    end

    it "should be successful" do
      fill_in "Name", :with => "test_project"
      click_link "Teaser"
      fill_in "Title", :with => "Project Title"
      click_button "Save"
      visit projects_path
      page.should have_content("Project Title")
    end
  end
  
end
