require 'rails'

module I18nRailsHelpers
  class Railtie < Rails::Engine
    initializer 'i18n_rails_helpers.helper' do
      ActionView::Base.send :include, I18nHelpers
      ActionView::Base.send :include, ContextualLinkHelpers
      ActionView::Base.send :include, ListLinkHelpers
    end
  end
end
