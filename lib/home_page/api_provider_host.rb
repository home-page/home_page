module HomePage
  class ApiProviderHost
    ENVIRONMENTS = [:development, :test, :staging, :production]
    ALIASES = { 
      dev: :development, testing: :test, stage: :staging, show: :staging, 
      live: :production, prod: :production 
    }
    FALLBACKS = { 
      development: [:development, :test, :staging, :production], 
      test: [:test, :development, :staging, :production],
      staging: [:staging, :production],
      production: [:production]
    }
    
    def initialize(provider, working_environment)
      @provider = provider
      @environment = working_environment.to_s.to_sym
    end
    
    def setting_namespace
      "home_page.apis.providers.#{@provider}.hosts"
    end
    
    def environment
      if ENVIRONMENTS.include?(@environment)
        @environment
      else
        ALIASES[@environment] || raise(
          NotImplementedError, 
          'Your environment is unknown. Please update alias mapping!'
        )
      end
    end
    
    def to_s
      host = nil
      
      FALLBACKS[environment].each do |provider_environment|
        host = Setting["#{setting_namespace}.#{provider_environment}"]
        
        break if host
      end
      
      unless host
        raise(
          NotImplementedError, 
          'The API provider does not support your environment!'
        )
      end
      
      host
    end
  end
end