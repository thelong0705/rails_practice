FactoryBot.define do
  factory :task do
    name { 'test task' }
    description { 'test task description' }
    user
  end
end