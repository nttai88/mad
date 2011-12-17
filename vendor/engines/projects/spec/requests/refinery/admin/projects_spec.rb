require "spec_helper"

describe Refinery do
  describe "Admin" do
    describe "projects" do
      login_refinery_user

      describe "projects list" do
        before(:each) do
          FactoryGirl.create(:project, :owner_name => "UniqueTitleOne")
          FactoryGirl.create(:project, :owner_name => "UniqueTitleTwo")
        end

        it "shows two items" do
          visit refinery_admin_projects_path
          page.should have_content("UniqueTitleOne")
          page.should have_content("UniqueTitleTwo")
        end
      end

      describe "create" do
        before(:each) do
          visit refinery_admin_projects_path

          click_link "Add New Project"
        end

        context "valid data" do
          it "should succeed" do
            fill_in "Owner Name", :with => "This is a test of the first string field"
            click_button "Save"

            page.should have_content("'This is a test of the first string field' was successfully added.")
            Refinery::Projects::Project.count.should == 1
          end
        end

        context "invalid data" do
          it "should fail" do
            click_button "Save"

            page.should have_content("Owner Name can't be blank")
            Refinery::Projects::Project.count.should == 0
          end
        end

        context "duplicate" do
          before(:each) { FactoryGirl.create(:project, :owner_name => "UniqueTitle") }

          it "should fail" do
            visit refinery_admin_projects_path

            click_link "Add New Project"

            fill_in "Owner Name", :with => "UniqueTitle"
            click_button "Save"

            page.should have_content("There were problems")
            Refinery::Projects::Project.count.should == 1
          end
        end
      end

      describe "edit" do
        before(:each) { FactoryGirl.create(:project, :owner_name => "A owner_name") }

        it "should succeed" do
          visit refinery_admin_projects_path

          within ".actions" do
            click_link "Edit this project"
          end

          fill_in "Owner Name", :with => "A different owner_name"
          click_button "Save"

          page.should have_content("'A different owner_name' was successfully updated.")
          page.should have_no_content("A owner_name")
        end
      end

      describe "destroy" do
        before(:each) { FactoryGirl.create(:project, :owner_name => "UniqueTitleOne") }

        it "should succeed" do
          visit refinery_admin_projects_path

          click_link "Remove this project forever"

          page.should have_content("'UniqueTitleOne' was successfully removed.")
          Refinery::Projects::Project.count.should == 0
        end
      end

    end
  end
end
