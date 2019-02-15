class Activity < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :master_activity

  validates :identifier, presence: true, uniqueness: true

  enum status: {
        todo: 1,
       doing: 2,
        done: 3,
    archived: 4
  }

  def set_identifier
    if self.client && self.master_activity
      case self.master_activity.frequency
      when "montly"
        frequency = "M"
      when "quarterly"
        frequency = "Q"
      when "annual"
        frequency = "A"
      when "single_time"
        frequency = "S"
      end
      self.identifier = "C#{self.client_id}-MA#{self.master_activity_id}/#{frequency}/#{Date.today.month}/#{Date.today.year}"
    else
      return false
    end
  end
end
