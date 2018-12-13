class Client < ApplicationRecord

  enum taxation: {       simples: 1,
                 presumed_profit: 2,
                     real_profit: 3,
                     deactivated: 4 }

  validates :cnpj, presence: true
  validates :social_name, presence: true
  validates :date_of_founding, presence: true
  validates :taxation, presence: true
  validates :contact, presence: true
  validates :telephone, presence: true
  validates :email, presence: true
  validates :start_accounting, presence: true
end
