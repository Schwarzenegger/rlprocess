FactoryBot.define do
  factory :master_activity do
    name { Faker::Types.rb_string }
    category { rand(1..3) }
    frequency { rand(1..3) }
    deadline_date { Faker::Date.forward(365) }
    deadline_month { [rand(1..12)] }
    deadline_day { rand(1..31) }
  end
end
