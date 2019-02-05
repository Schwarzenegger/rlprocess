FactoryBot.define do
  factory :payment_history do
    client
    receipt_date { Date.today }
    value { rand(0..1000) }
  end
end
