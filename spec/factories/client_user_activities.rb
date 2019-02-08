FactoryBot.define do
  factory :client_user_activity do
    client
    user
    master_activity
  end
end
