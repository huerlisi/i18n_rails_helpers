module I18nShortHandHelper
  # Shorthand of t_title(:index)
  #
  # If no +model+ is given, it uses the controller name to guess the model by
  # singularize it. +model+ can be both a class or an actual instance.
  #
  # Example:
  #   t_index('Account')         => 'Konto Liste'
  #   t_index                    => 'Konto Liste'  # when called in accounts_controller
  #
  def t_index(model = nil)
    shorthand_title(:index, model)
  end

  # Shorthand of t_title(:edit)
  #
  # If no +model+ is given, it uses the controller name to guess the model by
  # singularize it. +model+ can be both a class or an actual instance.
  #
  # Example:
  #   t_edit('Account')         => 'Konto bearbeiten'
  #   t_edit                    => 'Konto bearbeiten'  # when called in accounts_controller
  #
  def t_edit(model = nil)
    shorthand_title(:edit, model)
  end

  # Shorthand of t_title(:update)
  #
  # If no +model+ is given, it uses the controller name to guess the model by
  # singularize it. +model+ can be both a class or an actual instance.
  #
  # Example:
  #   t_update('Account')         => 'Konto bearbeiten'
  #   t_update                    => 'Konto bearbeiten'  # when called in accounts_controller
  #
  def t_update(model = nil)
    shorthand_title(:update, model)
  end

  # Shorthand of t_title(:show)
  #
  # If no +model+ is given, it uses the controller name to guess the model by
  # singularize it. +model+ can be both a class or an actual instance.
  #
  # Example:
  #   t_show('Account')         => 'Konto anzeigen'
  #   t_show                    => 'Konto anzeigen'  # when called in accounts_controller
  #
  def t_show(model = nil)
    shorthand_title(:show, model)
  end

  # Shorthand of t_title(:new)
  #
  # If no +model+ is given, it uses the controller name to guess the model by
  # singularize it. +model+ can be both a class or an actual instance.
  #
  # Example:
  #   t_new('Account')         => 'Konto erfassen'
  #   t_new                    => 'Konto erfassen'  # when called in accounts_controller
  #
  def t_new(model = nil)
    shorthand_title(:new, model)
  end
  alias :t_create :t_new

  # Shorthand of t_title(:delete)
  #
  # If no +model+ is given, it uses the controller name to guess the model by
  # singularize it. +model+ can be both a class or an actual instance.
  #
  # Example:
  #   t_delete('Account')         => 'Konto löschen'
  #   t_delete                    => 'Konto löschen'  # when called in accounts_controller
  #
  def t_delete(model = nil)
    shorthand_title(:delete, model)
  end
  alias :t_destroy :t_delete

  def shorthand_title(action, model)
    return t_title(action) if model.nil?
    t_title(action, model)
  end

  # Shorthand of t_action(:index)
  #
  # Example:
  #   ta_index        'Liste'
  #
  def ta_index
    t_action(:index)
  end

  # Shorthand of t_action(:edit)
  #
  # Example:
  #   ta_edit       'Bearbeiten'
  #
  def ta_edit
    t_action(:edit)
  end

  # Shorthand of t_action(:update)
  #
  # Example:
  #   ta_update       'Bearbeiten'
  #
  def ta_update
    t_action(:update)
  end

  # Shorthand of t_action(:show)
  #
  # Example:
  #   ta_show       'Anzeigen'
  #
  def ta_show
    t_action(:show)
  end

  # Shorthand of t_action(:new)
  #
  # Example:
  #   ta_new        'Erfassen'
  #
  def ta_new
    t_action(:new)
  end

  # Shorthand of t_action(:create)
  #
  # Example:
  #   ta_create       'Erfassen'
  #
  def ta_create
    t_action(:create)
  end

  # Shorthand of t_action(:delete)
  #
  # Example:
  #   ta_delete       'Löschen'
  #
  def ta_delete
    t_action(:delete)
  end

  # Shorthand of t_action(:destroy)
  #
  # Example:
  #   ta_destroy        'Löschen'
  #
  def ta_destroy
    t_action(:destroy)
  end

  # Shorthand of t_action(:cancel)
  #
  # Example:
  #   ta_cancel       'Abbrechen'
  #
  def ta_cancel
    t_action(:cancel)
  end

  # Shorthand of t_action(:back)
  #
  # Example:
  #   ta_back          => 'Zurück'
  #
  def ta_back
    t_action(:back)
  end

  # Shorthand of t_action(:previous)
  #
  # Example:
  #   ta_previous     => 'Zurück'
  #
  def ta_previous
    t_action(:previous)
  end

  # Shorthand of t_action(:next)
  #
  # Example:
  #   ta_next         => 'Weiter'
  #
  def ta_next
    t_action(:next)
  end
end
