class ProjectsUser < ActiveRecord::Base
  PARTNER = "Partner"
  ADVISOR = "Advisor"
  belongs_to :project
  belongs_to :user
end
