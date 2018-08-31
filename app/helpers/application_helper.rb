module ApplicationHelper
  def display_flash_messages(flash)
    html = ""
    flash.each do |type, message|
      unless message.blank?
        html << content_tag(:div, class: "flash-message alert #{ bootstrap_class_for(type) } alert-dismissable alert-modal") do
          content_tag(:span, message) + content_tag(:button, "x", class: "close")
        end
      end
    end

    if html.blank?
      return nil
    else
      return html.html_safe
    end
  end

  def fa(image)
    "<i class='fa fa-#{image.to_s}'></i>".html_safe
  end

  def bootstrap_class_for(flash_type)
    case flash_type
    when "success"
      "alert-success"
    when "error"
      "alert-danger"
    when "alert"
      "alert-warning"
    when "notice"
      "alert-info"
    else
      flash_type.to_s
    end
  end

  def ldate(dt, format = :long)
    dt ? I18n.l(dt, format: format) : ""
  end
end
