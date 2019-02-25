FactoryBot.define do
  factory :client do
    cnpj { Faker::Company.duns_number }
    social_name { Faker::Company.name }
    municipal_inscription { Faker::Company.ein }
    state_inscription { Faker::Company.ein }
    date_of_founding { Faker::Date.between(10.year.ago, Date.today)  }
    taxation { rand(1..3) }
    contact { Faker::PhoneNumber.cell_phone}
    email { Faker::Internet.email }
    telephone { Faker::PhoneNumber.phone_number }
    iss_password { Faker::Internet.password(8) }
    simples_password { Faker::Internet.password(8) }
    start_accounting { Faker::Date.between(10.year.ago, Date.today) }
    end_accounting { Date.today }
    honorary { Faker::Number.decimal(2) }
    observations { Faker::Lorem.sentences }
    nickname { Faker::Company.name }
  end
end
