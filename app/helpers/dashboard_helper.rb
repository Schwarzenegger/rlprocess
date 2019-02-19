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
end
