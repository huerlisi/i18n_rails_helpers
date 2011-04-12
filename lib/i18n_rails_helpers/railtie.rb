require 'i18n_rails_helpers'
require 'contextual_link_helpers'
require 'list_link_helpers'
require 'rails'

module I18nRailsHelpers
  class Railtie < Rails::Engine
    initializer :after_initialize do
      ActionController::Base.helper I18nRailsHelpers
      ActionController::Base.helper ContextualLinkHelpers
      ActionController::Base.helper ListLinkHelpers
    end
  end
end
