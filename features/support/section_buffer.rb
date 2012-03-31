module SectionBufferHelper

  def section_buff_helper(name)
    @sections_buff = {} unless @sections_buff
    @sections_buff = @sections_buff.merge(name => {}) unless @sections_buff[name]
    @sections_buff[name]
  end
  
  def section_buff_attribute_helper(section_name, *args)
    section = section_buff_helper(section_name)
    if args.size == 1
      section[args[0]]
    else
      section = section.merge(args[0] => args[1])
      @sections_buff = @sections_buff.merge(section_name => section)
    end
  end
  
end

World(SectionBufferHelper)