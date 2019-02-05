class PaymentHistory < ApplicationRecord
  belongs_to :client

  validates :receipt_date, presence: true
  validates :value, presence: true
end
