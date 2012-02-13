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
end
