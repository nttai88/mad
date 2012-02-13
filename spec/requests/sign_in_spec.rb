require "spec_helper"

describe "sign in" do

  before do
    # create root page
    FactoryGirl.create(:page, :link_url => "/")

    # create my-page
    FactoryGirl.create(:page, :title => "My Page")

    # create role
    Refinery::Role["Entrepreneur"]

    # create first user
    FactoryGirl.build(:user, :confirmed_at => Time.now).create_first
  end

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
