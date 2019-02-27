module DashboardHelper
  def activity_element_color(activity)
    if activity.is_past_deadlines?
      return "danger-element"
    elsif activity.is_close_to_deadline?
      return "warning-element"
    else
      return "info-element"
    end
  end

  def how_close_to_deadline(activity)
    days = (Date.today - activity.deadline)
    if days > 0
      return I18n.t("views.dashboard.late_activity", days: days)
    elsif days == 0
      return I18n.t("views.dashboard.deadline_today")
    else
      return I18n.t("views.dashboard.days_to_be_late", days: days)
    end
  end
end
