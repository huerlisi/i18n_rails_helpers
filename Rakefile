# coding: utf-8
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

begin
  GEM = "i18n_rails_helpers"
  AUTHOR = "Simon Hürlimann"
  EMAIL = "simon.huerlimann@cyt.ch"
  SUMMARY = "Rails i18n view helpers for things like crud actions, models and and attributes."
  HOMEPAGE = "http://github.com/huerlisi/i18n_rails_helpers/tree/master"
  
  gem 'jeweler', '>= 1.0.0'
  require 'jeweler'
  
  Jeweler::Tasks.new do |s|
    s.name = GEM
    s.summary = SUMMARY
    s.email = EMAIL
    s.homepage = HOMEPAGE
    s.description = SUMMARY
    s.author = AUTHOR
    
    s.require_path = 'lib'
    s.files = %w(MIT-LICENSE README.markdown Rakefile) + Dir.glob("{lib,test,rails,config}/**/*")
    
    # Runtime dependencies: When installing i18n_rails_helpers these will be checked if they are installed.
    # Will be offered to install these if they are not already installed.
    s.add_dependency 'activemodel'
    s.add_dependency 'i18n'
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "[i18n_rails_helpers:] Jeweler - or one of its dependencies - is not available. Install it with: sudo gem install jeweler -s http://gemcutter.org"
end

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the i18n_rails_helpers plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the i18n_rails_helpers plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'I18nRailsHelpers'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.markdown')
  rdoc.rdoc_files.include('lib/**/*.rb')
end