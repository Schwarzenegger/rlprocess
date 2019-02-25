class ActivityWorker
  include Sidekiq::Worker

  def perform(ids = nil)
    if ids != nil
      cuas = ClientUserActivity.find(ids)
    else
      cuas = ClientUserActivity.all
    end
    cuas.each do |cua|
      activity = Activity.new(client: cua.client, user: cua.user, master_activity: cua.master_activity)
      current_day = Date.today
      current_month = current_day.month
      current_year = current_day.year
      master_activity = cua.master_activity

      case master_activity.frequency
      when "montly"
        activity.deadline = Date.new(current_year, current_month, master_activity.deadline_day)
        activity.set_identifier
        if activity.save
          create_checklist(activity)
        end
      when "quarterly"
        if master_activity.deadline_month.include? current_month.to_s
          activity.deadline = Date.new(current_year, current_month, master_activity.deadline_day)
          activity.set_identifier
          if activity.save
            create_checklist(activity)
          end
        end
      when "annual"
        if master_activity.deadline_month.include? current_month.to_s
          activity.deadline = Date.new(current_year, current_month, master_activity.deadline_day)
          activity.set_identifier
          if activity.save
            create_checklist(activity)
          end
        end
      when "single_time"
        if master_activity.deadline_date.month == current_month
          activity.deadline = master_activity.deadline_date
          activity.set_identifier
          if activity.save
            create_checklist(activity)
          end
        end
      end
    end
  end

  def create_checklist(activity)
    master_activity = activity.master_activity
    master_activity.master_checklist_options.each do |checklist|
      acl = ActiviyCheckList.create(activity: activity, name: checklist.name)
    end
  end
end
