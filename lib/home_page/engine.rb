module HomePage
  class Engine < ::Rails::Engine
    config.autoload_paths << File.expand_path("../../../app/models/concerns", __FILE__)
    config.autoload_paths << File.expand_path("../../../app/controllers/concerns", __FILE__)
    config.i18n.load_path += Dir[File.expand_path("../../../config/locales/**/*.{rb,yml}", __FILE__)]
    
    config.generators{|g| g.orm :active_record }
    
    config.to_prepare do
      Rails.application.config.assets.precompile += %w(
        home_page/*
      )
    end 
  end
end
