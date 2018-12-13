class MasterActivity < ApplicationRecord

  enum category: { accounting: 1,
                   individual: 2,
                       fiscal: 3}

  enum frequency: { montly: 1,
                 quarterly: 2,
                     anual: 3,
               single_time: 4 }

  validates :name, presence: true
  validates :category, presence: true
  validates :frequency, presence: true
end
