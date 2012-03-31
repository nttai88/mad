Before do
  DatabaseCleaner.start

  FactoryGirl.build(:user, :username => 'admin',
                           :confirmed_at => Time.now).create_first

  er_role = Refinery::Role.find_by_title('Entrepreneur')

  FactoryGirl.build(:user, :username => 'entrepreneur',
                           :role_ids => er_role.id.to_s,
                           :confirmed_at => Time.now).create_user

  adv_role = Refinery::Role.find_by_title('Advisor')

  FactoryGirl.build(:user, :username => 'advisor',
                           :role_ids => adv_role.id.to_s,
                           :confirmed_at => Time.now).create_user
end

After do |scenario|
  DatabaseCleaner.clean
end