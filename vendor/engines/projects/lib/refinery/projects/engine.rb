require 'refinerycms-projects'

module Refinery
  module Projects
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery
      engine_name :refinery_projects

      initializer "register refinerycms_projects plugin" do |app|
        Refinery::Plugin.register do |plugin|
          plugin.name = "projects"
          plugin.url = {:controller => '/refinery/projects'}
          plugin.pathname = root
          plugin.name = 'projects'
          plugin.url = '/refinery/projects'

          plugin.activity = {
            :class_name => :'refinery/project'
          }
        end
      end

      config.after_initialize do
        Refinery.register_engine(Refinery::Projects)
      end
    end
  end
end
