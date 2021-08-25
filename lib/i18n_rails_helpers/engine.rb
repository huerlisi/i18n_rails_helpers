require 'rails'
require 'i18n_rails_helpers/model_helpers'
require 'i18n_rails_helpers/controller_helpers'

module I18nRailsHelpers
  class Engine < Rails::Engine
    initializer 'i18n_rails_helpers.helper' do
      Rails.application.reloader.to_prepare do
          ActionView::Base.send :include, I18nHelpers
          ActionView::Base.send :include, ContextualLinkHelpers
          ActionView::Base.send :include, ListLinkHelpers
        end
        ActionController::Base.class_eval { include ControllerHelpers }

      ActiveRecord::Base.class_eval do
        include ModelHelpers
        after_initialize :define_enum_t_methods
      end
    end
  end
end
