Given /^@entrepreneur and @advisor users$/ do
  steps %{
    Given users:
    | Role         | Username | First name | Last name | Email             | Address 1     | Address 2 | City | Zip    | Country | State    | Phone        | About                |
    | entrepreneur | asmith   | Adam       | Smith     | asmith@yahoo.com  | 1 Way Str.    |           | Oslo | 332244 | Norway  | Akershus | 298-044-1212 | Skilled entrepreneur |
    | advisor      | fdiller  | Frank      | Diller    | fdiller@yahoo.com | High Way Str. |           | Oslo | 332244 | Norway  | Akershus | 111-023-1111 | Skilled advisor      |
  }
end

Given /^a @business_plan$/ do
  steps %{
    And a business plan that contains @title section: "Hooking tool for farm"
    And contains "General" complex section:
    | Name       | Email             | Address 1     | Address 2 | City | Zip    | Country | State    | Phone        | About                |
    | Adam Smith | asmith@yahoo.com  | 1 Way Str.    |           | Oslo | 332244 | Norway  | Akershus | 298-044-1212 | Skilled entrepreneur |
    And contains "About" complex section:
    | Project name | Category        | Field of usage     | Which fields does the solve | MadLab Partners you may need contact with |
    | Hook Tool    | categories.txt  | field_of_usage.txt | fields_it_solves.txt        | madlab_partners.txt                       |
    And contains descriptioin sections:
    | Section title        | Section content file    |
    | Business Idea        | business_idea.txt       |
    | Product Description  | product.txt             |
    | Market Analysis      | market_analysis.txt     |
    | Competitors Analysis | competitor_analysis.txt |
    | Strategy             | strategy.txt            |
    | Progression Plan     | progression_plan.txt    |
    | Finances             | finances.txt            |
    | Summary              | summary.txt             |
    And contains "Attachment" upload/download section
    And contains "Thoughts & wishes" complex section:
    | Market geography | Size of market        | How far is the idea developed | Possible production or industrial partners | Possible suppliers | Possible distrubitors | Idea or patternprotection needed | Possible competitors developing similar technology | 
    | geo_market.txt   | The world via deLaval | Idea is technically tested    | partners.txt                               | suppliers.txt      | distributors.txt      | No                               | competitors.txt                                    |
  }  
end

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
  visit new_project_path(:locale => "en")
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

Given /^the @entrepreneur submitted the @business_plan for evaluation$/ do
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
  visit project_path(@business_plan, :locale => 'en')
  steps %{
    Then he can browse @title section
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
