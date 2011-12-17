module Refinery
  class ProjectsGenerator < Rails::Generators::Base

    source_root File.expand_path('../../../../', __FILE__)

    def rake_db
      rake("refinery_projects:install:migrations")
    end

  end
end
