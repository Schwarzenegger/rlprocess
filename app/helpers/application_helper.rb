module ApplicationHelper
  def display_flash_messages(flash)
    flash_messages = []
    flash.each do |type, message|
      unless message.blank?
        type = 'success' if type == 'notice'
        type = 'error'   if type == 'alert'
        text = "<script>toastr.#{type}('#{message}');</script>"
        flash_messages << text.html_safe if message
      end
    end

    flash_messages.join("\n").html_safe

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

  def ldate(dt, format = :default)
    dt ? I18n.l(dt, format: format) : ""
  end

  def translate_enum(klass, attribute, value)
    I18n.t("enums.#{klass}.#{attribute}.#{value}")
  end
end
