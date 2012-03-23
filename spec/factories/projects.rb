Factory.define :project do |p|
  p.title = 'my project'
  p.developed = 'Theoretical idea'
  p.association :user
end

