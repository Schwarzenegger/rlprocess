class MasterActivity < ApplicationRecord
  validates :name, presence: true
  validates :category, presence: true
  validates :frequency, presence: true
end
