# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'i18n_rails_helpers/version'

Gem::Specification.new do |s|
  s.name         = "i18n_rails_helpers"
  s.version      = I18nRailsHelpers::VERSION
  s.authors      = ["Simon Hürlimann (CyT)"]
  s.email        = "simon.huerlimann@cyt.ch"
  s.homepage     = "https://github.com/huerlisi/i18n_rails_helpers"
  s.summary      = "I18n Rails helpers"
  s.description  = "Rails i18n view helpers for things like crud actions, models and and attributes."

  s.files        = `git ls-files rails app lib config`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'

  s.extra_rdoc_files = ["README.markdown"]
end
