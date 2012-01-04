class Project < ActiveRecord::Base
  validates :owner_name, :presence => true
  validates :name, :presence => true
end
