class Section < ActiveRecord::Base
  belongs_to :project
  belongs_to :section_type
end
