FactoryBot.define do
  factory :activiy_check_list do
    activity
    name { Faker::Lorem.sentences }
  end
end
