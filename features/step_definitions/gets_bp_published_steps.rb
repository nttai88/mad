When /^the @entrepreneur set "([^"]*)" status in the @business_plan$/ do |arg1|
  visit project_path(@business_plan)
  bp_section_helper("Thoughts & wishes", true)
  bp_select_status_helper(arg1)
end

Then /^the @admin can see "([^"]*)" status of the @business_plan in his list$/ do |arg1|
  logout_helper
  login_helper('admin')
  visit project_path(@business_plan)
  bp_section_helper("Thoughts & wishes")
  page.should have_content arg1
end

When /^the @admin set "([^"]*)" status of the @business_plan$/ do |arg1|
  logout_helper
  login_helper('admin')
  visit project_path(@business_plan)
  bp_section_helper("Thoughts & wishes")
  bp_select_status_helper(arg1)
end

Then /^a visitor can see the @business_plan on the home page$/ do
  logout_helper
  visit '/'
  page.should have_content @business_plan
end
