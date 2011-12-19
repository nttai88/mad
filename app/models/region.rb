class Region < ActiveRecord::Base
  has_many :profile, :through => :region_selection
end
