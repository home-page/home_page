$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'home_page/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'home_page'
  s.version     = HomePage::VERSION
  s.authors     = ['Mathias Gawlista']
  s.email       = ['gawlista@gmail.com']
  s.homepage    = 'http://Home-Page.Software'
  s.summary     = 'Simple content management system for maintaining personal web pages but not usable yet.'
  s.description = '#Ruby on #Rails CMS with #Crowdsourcing support changes: http://bit.ly/home-page-0-0-6'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4.2.0'
  
  # rails 3
  s.add_dependency 'protected_attributes', '~> 1.0.5 '
  s.add_dependency 'activerecord-deprecated_finders', '~> 1.0.3'
  
  # model
  s.add_dependency 'devise', '~> 3.4.1'
  s.add_dependency 'friendly_id', '~> 5.1.0'
  s.add_dependency 'rails-settings-cached', '~> 0.4.1'
  s.add_dependency 'acts_as_list', '~> 0.4.0'
  
  # misc
  s.add_dependency 'nokogiri', '~> 1.6.6.2'
  s.add_dependency 'httparty', '~> 0.13.3'
  
  # View
  s.add_dependency 'therubyracer'
  s.add_dependency 'uglifier', '~> 2.7.1'
  s.add_dependency 'yui-compressor', '~> 0.12.0'
  s.add_dependency 'recaptcha', '~> 0.3.6'
  s.add_dependency 'simple_form', '~> 3.1.0'
  s.add_dependency 'simple-navigation', '~> 3.14.0'  
  s.add_dependency 'simple-navigation-bootstrap', '~> 1.0.0'
  s.add_dependency 'redcarpet', '~> 3.2.2'
  s.add_dependency 'albino', '~> 1.3.3'  
  s.add_dependency 'liquid', '~> 3.0.1'
  s.add_dependency 'auto_html', '~> 1.6.4'
  s.add_dependency 'will_paginate', '~> 3.0.7'
  s.add_dependency 'will_paginate-bootstrap', '~> 1.0.1'
  s.add_dependency 'turbolinks', '~> 2.5.3'
  s.add_dependency 'liquid', '~> 3.0.1'
    
  # CSS & JavaScript
  s.add_dependency 'twitter-bootswatch-rails', '~> 3.3.2.0'
  s.add_dependency 'twitter-bootswatch-rails-fontawesome', '~> 4.3.0.0'
  s.add_dependency 'bootstrap3-datetimepicker-rails', '~> 4.7.14'
  
  # JavaScript
  s.add_dependency 'jquery-rails', '~> 4.0.3'
  s.add_dependency 'jquery-ui-rails', '~> 5.0.3'
  s.add_dependency 'momentjs-rails', '>= 2.9.0'
  s.add_dependency 'selectize-rails', '~> 0.12.0'
   
  s.add_development_dependency 'mysql2'
  
  # Testing
  s.add_development_dependency 'rspec-rails', '~> 3.2.1'
  s.add_development_dependency 'spring-commands-rspec', '~> 1.0.4'
  s.add_development_dependency 'spring-commands-cucumber', '~> 1.0.1'
end
