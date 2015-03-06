$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'home_page/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'home_page'
  s.version     = HomePage::VERSION
  s.authors     = ['Mathias Gawlista']
  s.email       = ['gawlista@gmail.com']
  s.homepage    = 'http://murd.ch'
  s.summary     = 'Gem for maintaining personal home pages with pluggable modules for special interests and API mashups.'
  s.description = 'Gem for maintaining personal home pages with pluggable modules for special interests and API mashups.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4.2.0'

  s.add_development_dependency 'mysql2'
end
