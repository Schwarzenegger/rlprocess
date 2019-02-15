FactoryBot.define do
  factory :activity do
    client
    master_activity
    user
    status { 1 }
    when_moved_to_progress { DateTime.now }
    when_moved_to_done { DateTime.now }
    identifier { Faker::IDNumber.unique.valid }
  end
end
