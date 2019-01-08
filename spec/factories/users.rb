FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    role { rand(1..3) }
    salary { Faker::Number.decimal(2) }
    password { Faker::Internet.password(8) }

    trait :admin do
      role { 1 }
    end

    trait :manager do
      role { 2 }
    end

    trait :employee do
      role { 3 }
    end

  end
end
