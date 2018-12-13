class DateTimePickerInput < SimpleForm::Inputs::Base
  def input(_wrapper_options)
    template.content_tag(:div, class: "input-group date form_datetime", id: attribute_name.to_s) do
      template.concat span_table
      template.concat @builder.text_field(attribute_name, input_html_options)
    end
  end

  def input_html_options
    date = object.send(attribute_name)
    markup = { class: "form-control date-time-picker",
      "data-date-format" => "DD/MM/YYYY",
      type: "date-time-picker",
      value: date.blank? ? "" : date.strftime("%d/%m/%Y"),
      placeholder: placeholder_text.blank? ? "" : placeholder_text
    }
    markup = markup.merge({ disabled: "disabled" }) if self.options.try(:[],:input_html).try(:[],:disabled) == "disabled"

    markup
  end

  def span_table
    template.content_tag(:span, class: 'input-group-addon') do
      template.concat icon_calendar
    end
  end

  def icon_calendar
    "<i class='fa fa-calendar'></i>".html_safe
  end
end
