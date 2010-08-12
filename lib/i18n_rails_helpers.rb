require 'i18n_rails_helpers/railtie' if defined?(::Rails::Railtie)

module I18nRailsHelpers
  # Returns translated name for the given +attribute+.
  #
  # If no +model+ is given, it uses the controller name to guess the model by
  # singularize it.
  #
  # Example:
  #   t_attr('first_name', Patient) => 'Vorname'
  #   t_attr('first_name')          => 'Vorname' # when called in patients_controller views
  #
  def t_attr(attribute, model = nil)
    if model.is_a? Class
      model_name = model.name.underscore
    elsif model.nil?
      model_name = controller_name.singularize
    end
    I18n::translate(attribute, :scope => [:activerecord, :attributes, model_name])
  end

  # Returns translated name for the given +model+.
  #
  # If no +model+ is given, it uses the controller name to guess the model by
  # singularize it. +model+ can be both a class or an actual instance.
  #
  # Example:
  #   t_model(Account)     => 'Konto'
  #   t_model(Account.new) => 'Konto'
  #   t_model              => 'Konto' # when called in patients_controller views
  #
  def t_model(model = nil)
    if model.is_a? Class
      model_name = model.name.underscore
    elsif model.nil?
      model_name = controller_name.singularize
    else
      model_name = model.class.name.underscore
    end
    I18n::translate(model_name, :scope => [:activerecord, :models])
  end

  # Returns translated title for current +action+ on +model+.
  #
  # If no +action+ is given, it uses the current action.
  #
  # If no +model+ is given, it uses the controller name to guess the model by
  # singularize it. +model+ can be both a class or an actual instance.
  #
  # The translation file comming with the plugin supports the following actions
  # by default: index, edit, show, new, delete
  #
  # Example:
  #   t_title('new', Account') => 'Konto anlegen'
  #   t_title('delete')        => 'Konto löschen' # when called in accounts_controller views
  #   t_title                  => 'Konto ändern'  # when called in accounts_controller edit view
  #
  def t_title(action = nil, model = nil)
    action ||= action_name
    I18n::translate(action, :scope => 'crud.title', :model => t_model(model))
  end
  alias :t_crud :t_title
  
  # Returns translated string for current +action+.
  #
  # If no +action+ is given, it uses the current action.
  #
  # The translation file comes with the plugin supports the following actions
  # by default: index, edit, show, new, delete, back, next, previous
  #
  # Example:
  #   t_action('delete')        => 'Löschen'
  #   t_action                  => 'Ändern'  # when called in an edit view
  #
  def t_action(action = nil, model = nil)
    action ||= action_name
    I18n::translate(action, :scope => 'crud.action', :model => t_model(model))
  end
  
  # Returns translated deletion confirmation for +record+.
  #
  # It uses +record+.to_s in the message.
  #
  # Example:
  #   t_confirm_delete(@account) => 'Konto Kasse wirklich löschen'
  #
  def t_confirm_delete(record)
    I18n::translate('messages.confirm_delete', :model => t_model(record), :record => record.to_s)
  end
end
