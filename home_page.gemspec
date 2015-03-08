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
  s.description = 'Simple content management system with optional modules for maintaining personal web pages with pluggable modules for special interests and API mashups but not usable yet.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4.2.0'
  
  # rails 3
  s.add_dependency 'protected_attributes', '~> 1.0.5 '
  s.add_dependency 'activerecord-deprecated_finders', '~> 1.0.3'
  
  s.add_dependency 'therubyracer'#, :require => 'v8'
  s.add_dependency 'twitter-bootswatch-rails', '~> 3.3.2.0'
  s.add_dependency 'twitter-bootswatch-rails-fontawesome', '~> 4.3.0.0'
  s.add_dependency 'jquery-rails', '~> 4.0.3'
  s.add_dependency 'devise', '~> 3.4.1'
  s.add_dependency 'friendly_id', '~> 5.1.0'
  s.add_dependency 'recaptcha', '~> 0.3.6'
  s.add_dependency 'simple_form', '~> 3.1.0'
  s.add_dependency 'simple-navigation', '~> 3.14.0'  
  s.add_dependency 'simple-navigation-bootstrap', '~> 1.0.0'
  s.add_dependency 'redcarpet', '~> 3.2.2'
  s.add_dependency 'auto_html', '~> 1.6.4'
  s.add_dependency 'will_paginate', '~> 3.0.7'
  
  s.add_development_dependency 'mysql2'
end
