module ::Refinery
  module Admin
    class ProjectsController < ::Refinery::AdminController

      crudify :'refinery/project',
              :title_attribute => 'owner_name', :xhr_paging => true

    end
  end
end
