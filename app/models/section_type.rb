class SectionType < ActiveRecord::Base
  validates :title, :presence => true

  has_many :sections
  acts_as_tree :order => "position"
  translates :title
  default_scope :order => "position"

  def section_of(project)
    sections.where(:project_id => project.id, :section_type_id => self.id).first
  end

  def data_of(project)
    section = section_of(project)
    section.nil? ? "" : section.data
  end
  
end
