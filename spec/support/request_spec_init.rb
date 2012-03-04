module RequestSpecInit
  def setup_first_user_and_pages
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
  end

  def login_user
    before do
      visit new_refinery_user_session_path

      fill_in "Login", :with => Refinery::User.first.username
      fill_in "Password", :with => "123456"

      click_button "Sign in"
    end
  end
end
