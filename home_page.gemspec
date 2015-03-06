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

  s.add_development_dependency 'mysql2'
end
