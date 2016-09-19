module ApplicationHelper
  def flash_alert_class(key)
    case key.to_sym
    when :notice
      'alert-success'
    when :alert
      'alert-danger'
    else
      'alert-info'
    end
  end
end
