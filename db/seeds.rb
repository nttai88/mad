# Refinery seeds
Refinery::Pages::Engine.load_seed
Refinery::Inquiries::Engine.load_seed
Refinery::News::Engine.load_seed

Dir[Rails.root.join('db', 'seeds', '*.rb').to_s].each do |file|
  puts "Loading db/seeds/#{file.split(File::SEPARATOR).last}"
  load(file)
end

(Refinery::Role.all_roles).each do |role|
  Refinery::Role.find_or_create_by_title(role)
end

categories = ["Consumer Products", "Design", "Electronics", "Energy", "Environment", "Farming",
  "Health", "Houshold Products", "Industry", "IT", "Engine & Mechanics", "Other", "Telecom"]
categories.each do |category|
  Category.find_or_create_by_title(category)
end

Carmen::country_codes.each do |country|
  states = Carmen::states(country) rescue [["",""]]
  states.each do |state|
    Region.find_or_create_by_country_and_state(country, state[1])
  end
end
# Added by Refinery CMS Blog engine
Refinery::Blog::Engine.load_seed
