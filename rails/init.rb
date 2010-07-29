# Register helpers for Rails < 3
require File.join(File.dirname(__FILE__), *%w[.. lib i18n_rails_helpers])
ActionView::Base.send :include, I18nRailsHelpers
