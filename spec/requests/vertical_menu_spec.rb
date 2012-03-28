require 'spec_helper'

describe 'vertical menu' do
  setup_first_user_and_pages

  context 'user with admin role' do
    login_user

    specify 'can see and access backend link' do
      visit refinery.marketable_page_path('my-page')

      within "#menu_vert" do
        page.should have_selector("a[href='/refinery']")

        click_link 'Admin'

        page.current_path.should eq('/refinery')
      end
    end
  end

  context 'user without admin role' do
    # TODO: refactor this into seperate method so that it could be used
    # in other specs too
    before do
      user = FactoryGirl.create(:user, :confirmed_at => Time.now)

      visit refinery.new_refinery_user_session_path

      fill_in "Login", :with => user.username
      fill_in "Password", :with => "123456"

      click_button "Sign in"
    end

    specify 'cant see or access backend link' do
      visit refinery.marketable_page_path('my-page')

      within "#menu_vert" do
        page.should have_no_selector("a[href='/refinery']")
      end
    end
  end
end
