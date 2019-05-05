require 'rails'
require 'i18n_rails_helpers/model_helpers'
require 'i18n_rails_helpers/controller_helpers'

module I18nRailsHelpers
  class Engine < Rails::Engine
    initializer 'i18n_rails_helpers.helper' do
      ActionView::Base.send :include, I18nHelpers
      ActionController::Base.class_eval { include ControllerHelpers }

      ActiveRecord::Base.class_eval do
        include ModelHelpers
        after_initialize :define_enum_t_methods
      end
    end
  end
end
