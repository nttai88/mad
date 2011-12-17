
FactoryGirl.define do
  factory :project, :class => Refinery::Projects::Project do
    sequence(:owner_name) { |n| "refinery#{n}" }
  end
end

