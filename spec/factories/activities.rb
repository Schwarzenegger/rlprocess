FactoryBot.define do
  factory :activity do
    client
    master_activity
    user
    status { 1 }
    identifier { Faker::IDNumber.unique.valid }
  end
end
