class ProjectsSection < ActiveRecord::Base
  belongs_to :project
  belongs_to :section
end
