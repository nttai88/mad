class HtmlSectionType < SectionType

  def section_of(project)
    sections.where(:project_id => project.id, :section_type_id => self.id).first
  end
  
  def data_of(project)
    section = section_of(project)
    section.nil? ? "" : section.data
  end

end
