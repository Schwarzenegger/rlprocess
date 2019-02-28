FactoryBot.define do
  factory :activity_check_list do
    activity
    name { Faker::Lorem.sentences }
  end
end
