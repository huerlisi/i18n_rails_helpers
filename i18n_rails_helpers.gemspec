$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'i18n_rails_helpers/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name         = 'i18n_rails_helpers'
  s.version      = I18nRailsHelpers::VERSION
  s.authors      = ['Simon Huerlimann (CyT)', 'Kaspar Vollenweider']
  s.email        = ['simon.huerlimann@cyt.ch', 'vollenweider@gmail.com']
  s.homepage     = 'https://github.com/huerlisi/i18n_rails_helpers'
  s.summary      = 'I18n Rails helpers'
  s.description  = 'Rails i18n view helpers for things like crud actions, models and attributes.'
  s.license     = 'MIT'

  s.files       = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'bootsnap'
  s.add_dependency 'rails', '>= 6.0.0'
end
