require 'factory_girl'

FactoryGirl.define do
  factory :user, :class => Refinery::User do
    sequence(:username) { |n| "xxxxxx#{n}" }
    sequence(:email) { |n| "xxxxxx#{n}@xxxxxx.com" }
    password "123456"
    password_confirmation "123456"
  end

end
