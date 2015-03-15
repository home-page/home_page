module HomePage
  module Navigation
    class Base
      @@products = {}
      @@menu_options = {}
      
      def self.add_product(slug, text)
        @@products[slug] = text
      end
      
      def self.products
        @@products
      end
      
      def self.add_menu_option(resource, option, value)
        @@menu_options[resource] ||= {}
        @@menu_options[resource][option] = value
      end
      
      def self.menu_options(resource)
        @@menu_options[resource] ||= {}
        @@menu_options[resource]
      end
    end
    
    def self.code
      Proc.new do |navigation|
        navigation.items do |primary, options|
          primary.dom_class = 'nav navbar-nav'
          
          Setting['home_page.general.navigation.items'].each do |item|
            klass = "HomePage#{item.is_a?(Array) ? item.first.classify : ''}::Navigation"
            item = item.is_a?(Array) ? item.last : item
            instance_exec primary, HomePage::Navigation::Base.menu_options(item), &klass.constantize.menu_code(item)
          end
        end
      end
    end
    
    def self.menu_code(resource)
      case resource
      when 'page_modules'
        Proc.new do |primary, options|
          if user_signed_in?
            primary.item :page_module_collections, I18n.t('page_modules.index.title'), page_module_collections_path do |page_module_collections|
              page_module_collections.item :new, I18n.t('general.new'), new_page_module_collection_path
              
              unless (@page_module_collection.new_record? rescue true)
                page_module_collections.item :destroy, I18n.t('general.destroy'), page_module_collection_path(@page_module_collection), method: :delete, confirm: I18n.t('general.questions.are_you_sure')
                page_module_collections.item :new_module, I18n.t('page_modules.new.short_title'), new_page_module_collection_module_path(@page_module_collection)
                
                page_module_collections.item :modules, I18n.t('page_modules.index.short_title'), page_module_collection_modules_path do |page_modules|
                  unless (@page_module.new_record? rescue true)
                    page_modules.item :edit, I18n.t('general.edit'), edit_page_module_path(@page_module) do |page_module|
                      page_module.item :destroy, I18n.t('general.destroy'), page_module_path(@page_module), method: :delete, confirm: I18n.t('general.questions.are_you_sure')
                    end
                  end
                end
              end
            end
          end
        end
      when 'users'
        Proc.new do |primary, options|
          if user_signed_in?
            primary.item :users, I18n.t('users.index.title'), users_path do |users|
              unless (@user.new_record? rescue true) || current_user.try(:id) == @user.id
                if options[:after_resource_has_many]
                  instance_exec users, {}, &options[:after_resource_has_many]
                end
              end
            end
          end
        end
      when 'settings'
        Proc.new do |primary, options|
          primary.item :settings, I18n.t('settings.index.title'), settings_path if user_signed_in?
        end  
      when 'authentication'
        Proc.new do |primary, options|
          if user_signed_in?
            primary.item :sign_out, I18n.t('authentication.sign_out'), destroy_user_session_path, method: :delete
          else
            primary.item :authentication, I18n.t('authentication.title'), new_user_session_path do |authentication|
              authentication.item :sign_in, I18n.t('authentication.sign_in'), new_user_session_path
              authentication.item :sign_up, I18n.t('authentication.sign_up'), new_user_registration_path
            end
          end
        end
      end
    end
  end
end