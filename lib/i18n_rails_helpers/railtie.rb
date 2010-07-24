require 'i18n_rails_helpers'
require 'rails'

module I18nRailsHelpers
  class Railtie < Rails::Railtie
    initializer :after_initialize do
      ActionController::Base.helper I18nRailsHelpers
    end
  end
end
