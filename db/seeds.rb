# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Refinery seeds
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