class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :trackable

  enum role: { admin: 1,
             manager: 2,
            employee: 3 }

  validates :name, presence: true
  validates :role, presence: true
  validates :email, presence: true
  validates :salary, presence: true

end
