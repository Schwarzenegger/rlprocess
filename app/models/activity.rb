class Activity < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :master_activity
  has_many :activiy_check_lists

  validates :identifier, presence: true, uniqueness: true

  delegate :name, to: :master_activity
  delegate :nickname, to: :client

  enum status: {
        todo: 1,
       doing: 2,
        done: 3,
    archived: 4 } do


    event :start do
      before do
        self.when_moved_to_progress = DateTime.now
      end

      transition :todo => :doing
    end

    event :restart do
      before do
        self.when_moved_to_progress = nil
        self.when_moved_to_done = nil

        self.activiy_check_lists.each do |check|
          check.done = false
          check.save
        end
      end

      transition [:doing, :done, :archived] => :todo
    end

    event :finish do
      before do
        if self.when_moved_to_progress == nil
          self.when_moved_to_progress = DateTime.now
        end
        self.when_moved_to_done = DateTime.now
      end

      transition [:todo, :doing] => :done
    end

    event :archive do
      transition [:todo, :doing, :done] => :done
    end

  end

  def is_past_deadlines?
    if Date.today > self.deadline
      return true
    else
      return false
    end
  end

  def is_close_to_deadline?
    if Date.today > self.deadline - 2
      return true
    else
      return false
    end
  end

  def has_done_all_checklists?
    unless self.activiy_check_lists.empty?
      return self.activiy_check_lists.pluck(:done).all?
    else
      return true
    end
  end

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
