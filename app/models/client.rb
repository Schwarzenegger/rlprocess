class Client < ApplicationRecord

  enum taxation: {
             simples: 1,
     presumed_profit: 2,
         real_profit: 3,
         deactivated: 4,
         exempt: 5,
         others: 6
  }

  enum payment_frequency: {
                    montly: 1,
                 quarterly: 2,
                     annual: 3
  }

  has_many_attached :uploads
  has_and_belongs_to_many :activity_profiles
  has_many :payment_histories, dependent: :destroy
  has_many :client_user_activities, dependent: :destroy
  has_many :activities
  accepts_nested_attributes_for :client_user_activities, reject_if: :all_blank, allow_destroy: true

  validates :cnpj, presence: true
  validates :social_name, presence: true
  validates :date_of_founding, presence: true
  validates :taxation, presence: true
  validates :contact, presence: true
  validates :telephone, presence: true
  validates :email, presence: true
  validates :start_accounting, presence: true
end
