FactoryBot.define do
  factory :master_checklist_option do
    name { Faker::Types.rb_string }
    master_activity
  end
end
