module I18nRailsHelpers
  def t_attr(attribute, model = nil)
    if model.is_a? Class
      model_name = model.name.underscore
    elsif model.nil?
      model_name = controller_name.singularize
    end
    t(attribute, :scope => [:activerecord, :attributes, model_name])
  end

  def t_model(model = nil)
    if model.is_a? Class
      model_name = model.name.underscore
    elsif model.nil?
      model_name = controller_name.singularize
    end
    t(model_name, :scope => [:activerecord, :models])
  end

  def t_crud(action = nil, model = nil)
    if model.is_a? Class
      model_name = model.name.underscore
    elsif model.nil?
      model_name = controller_name.singularize
    end
    
    action ||= action_name
    t(action, :scope => :crud, :model => model_name.capitalize)
  end
  
  def t_confirm_delete(record)
    t('messages.confirm_delete', :record => "#{t_model(record.class)} #{record.to_s}")
  end
end

