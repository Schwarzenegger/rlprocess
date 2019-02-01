class ActivityProfile < ApplicationRecord
  has_and_belongs_to_many :master_activities
  has_and_belongs_to_many :clients

  validates :name, presence: true
end
