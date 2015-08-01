module ApplicationHelper

  def bootstrap_class_for(flash_type)
    h = HashWithIndifferentAccess.new({ 
      success: "alert-success", 
      error: "alert-danger", 
      alert: "alert-warning", 
      notice: "alert-info" 
    })

    h[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    tags = flash.map do |msg_type, message|
      content_tag(:div, sanitize(message), class: "alert #{bootstrap_class_for(msg_type)} fade in")
    end
    tags.join.html_safe
  end

end
