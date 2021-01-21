require 'rails'
require 'i18n_rails_helpers/model_helpers'
require 'i18n_rails_helpers/controller_helpers'

require 'action_view_helpers/i18n_helpers'
require 'action_view_helpers/contextual_link_helpers'
require 'action_view_helpers/list_link_helpers'

module I18nRailsHelpers
  class Engine < Rails::Engine
    initializer 'i18n_rails_helpers.helper' do
      ActiveSupport.on_load(:action_view) do
        include I18nHelpers
        include ContextualLinkHelpers
        include ListLinkHelpers
      end

      ActionController::Base.class_eval { include ControllerHelpers }

      ActiveRecord::Base.class_eval do
        include ModelHelpers
        after_initialize :define_enum_t_methods
      end
    end
  end
end
