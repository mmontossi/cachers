$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'cachers/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'cachers'
  s.version     = Cachers::VERSION
  s.authors     = ['mmontossi']
  s.email       = ['mmontossi@museways.com']
  s.homepage    = 'https://github.com/mmontossi/cachers'
  s.summary     = 'Cachers for rails'
  s.description = 'Dedicated classes to isolate redis logic in rails.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.1'

  s.add_development_dependency 'pg', '~> 0.21'
  s.add_development_dependency 'redis', '~> 3.3'
end
