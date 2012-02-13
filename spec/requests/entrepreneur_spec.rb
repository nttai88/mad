require "spec_helper"

describe "Entrepreneur" do

  before do
    # create root page
    FactoryGirl.create(:page, :link_url => "/")

    # create my-page
    FactoryGirl.create(:page, :title => "My Page")

    # create Entrepreneur role
    @role = Refinery::Role["Entrepreneur"]

    # create first user
    FactoryGirl.build(:user, :confirmed_at => Time.now).create_first
  end

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
          choose "user_role_ids_#{@role.id}"
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

end
