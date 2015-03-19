module HomePage
  module ApplicationHelper
    include AutoHtml
    
    def self.root_model_class_name_helper(resource)
      if resource.class.superclass.name == 'ActiveRecord::Base'
        resource.class.name
      elsif resource.class.superclass.name == 'Object'
        # classes like mongo db models without a specific superclass
        resource.class.name
      else
        resource.class.superclass.name
      end
    end
    
    def root_model_class_name(resource)
      ::HomePage::ApplicationHelper.root_model_class_name_helper(resource)
    end
    
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
        type = :danger   if ["alert", "error", "recaptcha_error"].include? type.to_s
        content += raw(message)
        text = content_tag(:div, content, :class => "alert fade in alert-#{type}") 
        flash_messages << text if message
      end
      
      flash_messages.join("\n").html_safe
    end
    
    def markdown(text)
      syntax_highlighter(
        auto_html(text) do 
          youtube(width: 515, height: 300)
          dailymotion(width: 515, height: 300)
          vimeo(width: 515, height: 300)
          google_video(width: 515, height: 300)
          image
    
          redcarpet(
            renderer: Redcarpet::Render::XHTML.new(
              no_images: false, no_styles: true, hard_wrap: true, with_toc_data: true
            ),
            markdown_options: { no_intra_emphasis: true, autolink: true, fenced_code_blocks: true }
          )
          link :target => "_blank", :rel => "nofollow"
        end.gsub(/(>https?:\/\/[^\<\\]+)/) do |match| 
          truncate(match)
        end.gsub('<pre>', '').gsub('</pre>', '')
      ).html_safe
    end
    
    def syntax_highlighter(html)  
      doc = Nokogiri::HTML(html)  
      
      doc.search("//code[@class]").each do |code|  
        code.replace Albino.colorize(code.text.rstrip, code[:class])  
      end  
      
      doc.to_s  
    end  
    
    def attribute_translation(attribute, current_resource = nil)
      current_resource = current_resource || resource
      t("activerecord.attributes.#{root_model_class_name(current_resource).underscore}.#{attribute}",
        default: t("attributes.#{attribute}")
      )
    end
  end
end