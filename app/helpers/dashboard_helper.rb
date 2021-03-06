module DashboardHelper
  def activity_status_label(activity)
    label_class = ""

    if activity.done?
      label_class = "label-success"
    else
      if activity.is_past_deadlines?
        label_class = "label-danger"
      elsif activity.is_close_to_deadline?
        label_class = "label-warning"
      else
        label_class = "label-primary"
      end
    end

    content_tag(:span, class: "label #{label_class}") do
      t("views.dashboard.#{activity.status}")
    end
  end

  def month_year_name(month, year)
    return "#{I18n.t('date.month_names')[month  - 1]}/#{year}"
  end

  def set_competence(activity)
    if activity.competence == "competence_month"
      return "#{activity.deadline.month}/#{activity.deadline.year}"
    elsif activity.competence == "next_month"
      return "#{activity.deadline.month - 1}/#{activity.deadline.year}"
    else
      return ""
    end

  end

  def how_close_to_deadline(activity)
    if activity.done?
      return I18n.t("views.dashboard.done_activity", date: I18n.l(activity.when_moved_to_done))
    end

    days = (Date.today - activity.deadline).to_i
    if days > 0
      return I18n.t("views.dashboard.late_activity", days: days)
    elsif days == 0
      return I18n.t("views.dashboard.deadline_today")
    else
      return I18n.t("views.dashboard.days_to_be_late", days: -days)
    end
  end
end
