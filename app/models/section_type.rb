class SectionType < ActiveRecord::Base
  validates :title, :presence => true

  has_many :sections

  translates :title

end
