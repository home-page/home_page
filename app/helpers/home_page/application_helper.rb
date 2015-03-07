module HomePage
  module ApplicationHelper
    # Taken from https://github.com/seyhunak/twitter-bootstrap-rails
    # Modified to support html in flash message
    def bootstrap_flash_raw
      flash_messages = []
      
      flash.each do |type, message|
        flash.delete(type)
        
        # Skip Devise :timeout and :timedout flags
        next if type == :timeout
        next if type == :timedout
        
        content =  type.to_s == "filter" ? "" : content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert")
        type = :success if ["notice", "filter"].include? type.to_s
        type = :danger   if ["alert", "error"].include? type.to_s
        content += raw(message)
        text = content_tag(:div, content, :class => "alert fade in alert-#{type}") 
        flash_messages << text if message
      end
      
      flash_messages.join("\n").html_safe
    end
  end
end