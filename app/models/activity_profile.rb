class ActivityProfile < ApplicationRecord
  has_and_belongs_to_many :master_activities

  validates :name, presence: true
end
