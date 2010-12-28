# Register helpers for Rails < 3
require File.join(File.dirname(__FILE__), *%w[.. lib i18n_rails_helpers])
require File.join(File.dirname(__FILE__), *%w[.. lib contextual_link_helpers])
ActionView::Base.send :include, I18nRailsHelpers
ActionView::Base.send :include, ContextualLinkHelpers
