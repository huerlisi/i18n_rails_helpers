module I18nHelpers
  # Returns translated identifier
  def t_page_head
    if params[:id] and resource
      return "%s %s" % [t_title, resource.to_s]
    else
      return t_title
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
  # Using pluralization:
  #
  # For working pluralization, there needs to be the keys :one, and :other in
  # de.activerecord.attributes.client.visit.one, de.activerecord.attributes.client.visit.other
  # English will allways pluralize, because ruby does that for us.
  #
  #   t_attr(:meeting, count: 2)           => 'Besuch'  # when called in clients_controller views
  #   t_attr(:meeting, Client, count: 2)   => 'Besuche' # when called from another controllers views
  #
  def t_attr(attribute, model = nil, count: 1)
    model_class = model if model.is_a? Class
    model_class = controller_name.classify.constantize if model.nil?
    return model_class.human_attribute_name(attribute, count: count).pluralize if en_plural?
    model_class.human_attribute_name(attribute, count: count)
  end

  def en_plural?(count)
    locale == :en && count > 1
  end

  # Returns translated name for the given +model+.
  #
  # If no +model+ is given, it uses the controller name to guess the model by
  # singularize it. +model+ can be both a class or an actual instance.
  #
  # Example:
  #   t_model(Account)     => 'Konto'
  #   t_model(Account.new) => 'Konto'
  #   t_model              => 'Konto'   # when called in patients_controller views
  #
  # Using pluralization:
  #
  # For working pluralization, there needs to be the keys :one, and :other in
  # de.activerecord.models.client.one, de.activerecord.models.client.other
  # English will allways pluralize, because ruby does that for us.
  #
  #   t_model(Client, count: 2)   => 'Kunden' # when called from another controllers views
  #   t_model(count: 2)           => 'Kunden' # when called in clients_controller views
  #
  def t_model(model = nil, count: 1)
    return translate_model(model, 1).pluralize if en_plural?
    translate_model(model, count)
  end

  def translate_model(model, count)
    I18n.translate(model_i18n_key(model), scope: [:activerecord, :models], count: count)
  end

  def model_i18n_key(model)
    return controller_name.singularize.to_sym if model.nil?
    return model.name.underscore.to_sym if model.is_a? Class
    model.class.name.underscore.to_sym
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
    if model
      context = model.name.pluralize.underscore
    else
      context = controller_name.underscore
    end

    I18n::translate("#{context}.#{action}.title", :default => [:"crud.title.#{action}"], :model => t_model(model))
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

  # Returns translated drop down field prompt for +model+.
  #
  # If no +model+ is given, it tries to guess it from the controller.
  #
  # Example:
  #   t_select_prompt(Account) => 'Konto auswählen'
  #
  def t_select_prompt(model = nil)
    I18n::translate('messages.select_prompt', :model => t_model(model))
  end
end
