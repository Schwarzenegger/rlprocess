class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :trackable

  enum role: { admin: 1,
             manager: 2,
            employee: 3 }

  has_many :activities
  has_many :client_user_activities

  validates :name, presence: true
  validates :role, presence: true
  validates :email, presence: true
  validates :salary, presence: true

end
