class Section < ActiveRecord::Base
  belongs_to :project
  belongs_to :section_type

  ajaxful_rateable :stars => 10, :dimensions => [:data]
end
