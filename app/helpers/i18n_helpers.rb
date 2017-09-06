module I18nHelpers
  # Returns translated identifier
  def t_page_head
    if params[:id] && resource
      format('%s %s', t_title, resource.to_s)
    else
      t_title
    end
  end

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
      model_class = model
    elsif model.nil?
      model_class = controller_name.classify.constantize
    end
    model_class.human_attribute_name(attribute)
  end

  # Returns translated name for the given +model+.
  #
  # If no +model+ is given, it uses the controller name to guess the model by
  # singularize it. +model+ can be both a class or an actual instance.
  #
  # Parameter counts default returns singular default or default model translation if
  # translation keys activerecord.models.model_name.one is not present.
  #
  # If count > 1 is passed it will return the plural translation,
  # provided with activerecord.models.model_name.other.
  #
  # Example:
  #   t_model(Account)     => 'Konto'
  #   t_model(Account.new) => 'Konto'
  #   t_model              => 'Konto' # when called in patients_controller views
  #   t_model(count: 2)    => 'Kontos' # when activerecord.models.account.other is present
  #   t_model(count: 2)    => 'Konto' # when activerecord.models.account.other isn't present
  #
  def t_model(model = nil, count: 1)
    I18n.translate(find_model_key(model), scope: [:activerecord, :models], count: count)
  end

  def find_model_key(model = nil)
    if model.is_a? ActiveModel::Naming
      model.model_name.singular
    elsif model.class.is_a? ActiveModel::Naming
      model.class.model_name.singular
    elsif model.is_a? Class
      model.name.underscore
    elsif model.nil?
      controller_name.singularize
    else
      model.class.name.underscore
    end
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
  # You may provide controller specific titles in the translation file. The keys
  # should have the following format:
  #
  #   #{controller_name}.#{action}.title
  #
  # Example:
  #   t_title('new', Account') => 'Konto anlegen'
  #   t_title('delete')        => 'Konto löschen' # when called in accounts_controller views
  #   t_title                  => 'Konto ändern'  # when called in accounts_controller edit view
  #
  def t_title(action = nil, model = nil)
    action ||= action_name
    I18n.translate("#{t_context(model)}.#{action}.title", default: [:"crud.title.#{action}"],
      model: t_model(model))
  end
  alias :t_crud :t_title

  def t_context(model = nil)
    if model
      model.name.pluralize.underscore
    else
      controller_name
    end
  end

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
    I18n.translate(action, scope: 'crud.action', model: t_model(model))
  end

  # Returns translated deletion confirmation for +record+.
  #
  # It uses +record+.to_s in the message.
  #
  # Example:
  #   t_confirm_delete(@account) => 'Konto Kasse wirklich löschen'
  #
  def t_confirm_delete(record)
    I18n.translate('messages.confirm_delete', model: t_model(record), record: record.to_s)
  end

  # Returns translated drop down field prompt for +model+.
  #
  # If no +model+ is given, it tries to guess it from the controller.
  #
  # Example:
  #   t_select_prompt(Account) => 'Konto auswählen'
  #
  def t_select_prompt(model = nil)
    I18n.translate('messages.select_prompt', model: t_model(model))
  end
end
