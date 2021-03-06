class MasterActivity < ApplicationRecord
  has_and_belongs_to_many :activity_profiles
  has_many :master_checklist_options, inverse_of: :master_activity
  has_many :client_user_activities
  has_many :activities

  accepts_nested_attributes_for :activities
  accepts_nested_attributes_for :master_checklist_options, reject_if: :all_blank, allow_destroy: true

  enum category: { accounting: 1,
                   individual: 2,
                       fiscal: 3 }

  enum frequency: { montly: 1,
                 quarterly: 2,
                     annual: 3,
               single_time: 4 }

  enum competence: { competence_month: 1,
                    next_month: 2
  }

  validates :name, presence: true
  validates :category, presence: true
  validates :frequency, presence: true
end
