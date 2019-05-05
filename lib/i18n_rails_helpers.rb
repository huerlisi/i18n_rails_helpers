require 'i18n_rails_helpers/engine'

module I18nRailsHelpers
  # Configuration
  # =============

  # Setup
  #
  # Use this to configure I18nRailsHelpers in an initializer.
  #
  #     I18nRailsHelpers.setup do |config|
  #       config.option = 'value'
  #     end
  #
  def self.setup
    yield self
  end

  # CSS class to use for the contextual link container
  mattr_accessor :contextual_class
  @@contextual_class = 'contextual'

  # CSS class to use for contextual links
  mattr_accessor :contextual_link_class
  @@contextual_link_class = 'btn'

  # Bootstrap icon class
  mattr_accessor :boot_icon_class_template
  @@boot_icon_class_template = 'icon icon-%s '
end
