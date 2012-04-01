module BpAdapterHelper

  def bp_title_helper(*args)
    if args.size == 0
    else
      page.find('#title .edit').click
      fill_in 'project_title', :with => args[0]
      page.find('#title .save').click
    end
  end
  
  def bp_copy_contact_info_helper
    check('use_existing')    
  end

  def bp_section_helper(name, edit_mode=false)
    click_link('Hide All')
    case name
    when 'Business Idea', 'Product Description', 'Summary', 'Market Analysis',\
         'Competitors Analysis', 'Strategy', 'Progression Plan', 'Finances'
      #sleep 1
      page.execute_script("nestedAccordion.pr(-1);")
      open_section('Business Plan', false)
      open_subsection(name, edit_mode)
    else
      open_section(name, edit_mode)
    end
    @current_section = name
  end
  
  def bp_section_save_helper
    case @current_section
    when 'Business Idea', 'Product Description', 'Summary'
      page.find("#nested h3:contains('#{ @current_section }') .save").click
    else
      page.find("#acc h3:contains('#{ @current_section }') .save").click
    end
  end
  
  def bp_description_helper(*args)
    case @current_section
    when 'Business Idea'
      wym_ix = 0
    when 'Product Description'
      wym_ix = 1
    when 'Summary'
      wym_ix = 2
    when 'Market Analysis'
      wym_ix = 3
    when 'Competitors Analysis'
      wym_ix = 4
    when 'Strategy'
      wym_ix = 5
    when 'Progression Plan'
      wym_ix = 6
    when 'Finances'
      wym_ix = 7
    else
      wym_ix = -1
    end
    if args.size == 1
    else
      value = args[1].respond_to?(:each) ? args[1].join(' ').to_s : args[1]
      value = '<span>' + value + '</span>'

      #puts("here is encoding===>" + value.encoding.name)
      #puts @current_section
      #puts("here is wym ix====>: #{ wym_ix }")
      #puts value

      page.execute_script("jQuery.wymeditors(#{ wym_ix }).html('#{ value }');")
      page.execute_script("jQuery.wymeditors(#{ wym_ix }).update();")
    end
  end
  
  def bp_section_attribute_helper(*args)
    if args.size == 1
    else
      if args[1].respond_to?(:each)
        args[1].each do |value|
          set_attr_value(args[0], value)
        end
      else
        set_attr_value(args[0], args[1])
      end
    end
  end
  
  def bp_add_advisor_helper(project_id, advisor)
    visit project_members_path(project_id)
    full_name = Refinery::User.find_by_username(advisor).full_name
    select full_name, :from => 'advisor_id_'
    click_on 'advisor_submit'
  end

private

  def open_subsection(subsection_name, edit_mode)
    if edit_mode
      page.execute_script("$('#nested h3:contains(" + '"' + subsection_name + '"' + ")').mouseover();")
      page.find("#nested h3:contains('#{ subsection_name }') .edit").click
    else
      page.find("#nested h3:contains('#{ subsection_name }')").click
    end
  end

  def open_section(name, edit_mode)
    if edit_mode
      page.execute_script("$('#acc h3:contains(" + '"' + name + '"' + ")').mouseover();")
      page.find("#acc h3:contains('#{ name }') .edit").click
    else
      page.find("#acc h3:contains('#{ name }')").click
    end
  end

  def set_attr_value(name, value)
    case @current_section
    when 'About'
      about_attr_value(name, value)
    when 'Thoughts & wishes'
      wishes_attr_value(name, value)
    else
      fill_in name, :with => value
    end
  end

  def wishes_attr_value(name, value)
    case name
    when 'Market geography'
      fill_in 'project_marked_geographic', :with => value
    when 'Size of market'
      fill_in 'project_marked_size', :with => value
    when 'Possible production or industrial partners'
      fill_in 'project_industrial_partners', :with => value
    when 'Possible suppliers'
      fill_in 'project_suppliers', :with => value
    when 'Possible distrubitors'
      fill_in 'project_distributers', :with => value
    when 'Idea or patternprotection needed'
      fill_in 'project_idea', :with => value
    when 'Possible competitors developing similar technology'
      fill_in 'project_competitors2', :with => value
    when 'How far is the idea developed'
      fill_in 'project_patenting', :with => value
    else
      fill_in name, :with => value
    end    
  end

  def about_attr_value(name, value)
    case name
    when 'Category'
      select value, :from => 'project_category_ids'
    when 'MadLab Partners you may need contact with'
      check(value)
    when 'Field of usage'
      fill_in 'project_usage', :with => value
    when 'Which fields does the solve'
      fill_in 'project_solves', :with => value
    else
      fill_in name, :with => value
    end    
  end
end

World(BpAdapterHelper)