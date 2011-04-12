module ListLinkHelpers
  # List link helpers
  def list_link_to(action, url, options = {})
    options.merge!(:class => "icon-#{action}-text", :title => t_action(action))
    
    link_to(t_action(action), url, options)
  end
  
  def list_link_for(action, resource_or_model = nil)
    # Handle both symbols and strings
    action = action.to_s
    
    # Resource and Model setup
    # Use controller name to guess resource or model if not specified
    case action
    when 'new', 'index'
      model = resource_or_model || controller_name.singularize.camelize.constantize
    when 'show', 'edit', 'delete'
      resource = resource_or_model || instance_variable_get("@#{controller_name.singularize}")
      model = resource.class
    end
    model_name = model.to_s.underscore
    
    # No link if CanCan is used and current user isn't authorized to call this action
    return if respond_to?(:can?) and ! can?(action.to_sym, model)
    
    # Link generation
    case action
    when 'new'
      return list_link_to(action, send("new_#{model_name}_path"))
    when 'show'
      return list_link_to(action, send("#{model_name}_path", resource))
    when 'edit'
      return list_link_to(action, send("edit_#{model_name}_path", resource))
    when 'delete'
      return list_link_to(action, send("#{model_name}_path", resource), :confirm => t_confirm_delete(resource), :method => :delete)
    when 'index'
      return list_link_to(action, send("#{model_name.pluralize}_path"))
    end
  end
  
  def list_links_for(action = nil, resource_or_model = nil)
    # Use current action if not specified
    action ||= action_name
    
    # Handle both symbols and strings
    action = action.to_s
    
    actions = []
    case action
    when 'new', 'create'
      actions << 'index'
    when 'show'
      actions += ['edit', 'delete', 'index']
    when 'edit', 'update'
      actions += ['show', 'delete', 'index']
    when 'index'
      actions << 'new'
    end
    
    links = actions.map{|link_for| contextual_link_to(link_for, resource_or_model)}
    
    return links.join("\n").html_safe
  end
end
