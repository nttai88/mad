Given /^users:$/ do |table|
  data = table.raw
  data.each do |row|
    unless row[0] == 'Role'
      case row[0]
      when 'entrepreneur'
        @entrepreneur = row[1] # keep entrepreneur username for fast access
      when 'advisor'
        @advisor = row[1] # keep advisor username for fast access
      end
      login_helper row[0] # In seeds a username is equal its role
      open_user_editor_helper(row[0]) # username is still as role
      column_ix = 0
      row.each do |column|
        user_attribute_helper(data[0][column_ix], column) unless column_ix == 0 # skip titles
        column_ix += 1
      end
      save_user_helper
      logout_helper
    end
  end
end

Given /^a business plan that contains @title section: "([^"]*)"$/ do |arg1|
  @title = arg1
end

Given /^contains descriptioin sections:$/ do |table|
  data = table.raw
  data.each do |row|
    unless row[0] == 'Section title'
      load_data(row[0], row[1])
    end
  end
end

Given /^contains "([^"]*)" upload\/download section$/ do |arg1|
  #To do...
end

Given /^contains "([^"]*)" complex section:$/ do |arg1, table|
  section_buff_helper(arg1)
  data = table.raw
  column = 0
  data[0].each do |title|
    value = data[1][column]
    if value =~ /.txt/
      value = read_data_file(value)
    end
    section_buff_attribute_helper(arg1, title, value)
    column += 1
  end
end

Given /^the entrepreneur created a new business plan$/ do
  login_helper @entrepreneur
  visit new_project_path
end

When /^the entrepreneur submitted @title section$/ do
  bp_title_helper(@title)
end

When /^submitted a copy of his contact data to "([^"]*)" section$/ do |arg1|
  bp_section_helper(arg1, true)
  bp_copy_contact_info_helper
  bp_section_save_helper  
end

When /^submitted description sections:$/ do |table|
  data = table.raw
  data.each do |row|
    bp_section_helper(row[0], true)
    bp_description_helper(row[0], file_data_helper(row[0]))
    bp_section_save_helper
  end
end

When /^submitted "([^"]*)" upload\/download section$/ do |arg1|
  #To do...
end

When /^submitted "([^"]*)" complex section$/ do |arg1|
  bp_section_helper(arg1, true)
  section = section_buff_helper(arg1)
  section.keys.each do |key|
    bp_section_attribute_helper(key, section[key])
  end
  bp_section_save_helper
end

Then /^he can browse @title section$/ do
  page.should have_content @title
end

Then /^can browse descriptions:$/ do |table|
  data = table.raw
  data.each do |row|
    bp_section_helper(row[0])
    content = file_data_helper(row[0])
    page.should have_content content.respond_to?(:each) ? content.join(' ').to_s : content
  end
end

Then /^can browse "([^"]*)" upload\/download section$/ do |arg1|
  #To do...
end

Then /^can browse "([^"]*)" complex section$/ do |arg1|
  bp_section_helper(arg1)
  section = section_buff_helper(arg1)
  section.keys.each do |key|
    # This case is a dirty patch for incomplete implementation MUST REMOVE IT!
    case key
    when 'Category', 'Email'
      #Not implemetned functionality
    else
      page.should have_content \
        section[key].respond_to?(:each) ? section[key].join(' ').to_s : section[key]
    end
  end
end

Given /^the entrepreneur submitted a @business_plan for evaluation$/ do
  steps %{
    Given the entrepreneur created a new business plan
    When the entrepreneur submitted @title section
    And submitted a copy of his contact data to "General" section
    And submitted "About" complex section
    And submitted description sections:
    | Business Idea        |
    | Product Description  |
    | Market Analysis      |
    | Competitors Analysis |
    | Strategy             |
    | Progression Plan     |
    | Finances             |
    | Summary              |
    And submitted "Attachment" upload/download section
    And submitted "Thoughts & wishes" complex section
  }
  @business_plan = Project.last.id
end

When /^the admin assigned the @advisor to the @business_plan$/ do
  logout_helper
  login_helper('admin')
  bp_add_advisor_helper(@business_plan, @advisor)
end

Then /^the @advisor can see the @business_plan in his list$/ do
  logout_helper
  login_helper(@advisor)
end

Then /^he can browse the @business_plan$/ do
  visit project_path(@business_plan)
  steps %{
    Then he can browse @title section
    And can browse "General" complex section
    And can browse "About" complex section
    And can browse descriptions:
    | Business Idea        |
    | Product Description  |
    | Market Analysis      |
    | Competitors Analysis |
    | Strategy             |
    | Progression Plan     |
    | Finances             |
    | Summary              |
    And can browse "Attachment" upload/download section
    And can browse "Thoughts & wishes" complex section
  }
end
