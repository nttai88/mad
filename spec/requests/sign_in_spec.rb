require "spec_helper"

describe "sign in" do

  setup_first_user_and_pages

  let(:user) { Refinery::User.last }

  it "redirects to overview page after successful sign in" do
    visit root_path

    click_link "Sign in"

    fill_in "Login", :with => user.username
    fill_in "Password", :with => "123456"
    click_button "Sign in"

    page.current_path.should eq("/my-page")
  end
end
