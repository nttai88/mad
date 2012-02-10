require "spec_helper"

describe "Entrepreneur sign-up and sign-in" do

  before do
    # create Entrepreneur role
    @role = Refinery::Role["Entrepreneur"]

    # create first user
    FactoryGirl.build(:user, :confirmed_at => Time.now).create_first
  end

  let!(:user) { FactoryGirl.create(:user) }

  it "registers user with entrepreneur role" do
    visit root_path

    click_link "Sign up"

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

      page.should have_content("You have been logged in successfully.")
      
    end
  end
end
