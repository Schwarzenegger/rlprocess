class ClientUserActivity < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :master_activity
end
