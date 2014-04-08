module ListLinkHelpers
  # List link helpers
  def list_link_to(action, url, options = {})
    options.merge!(:class => "icon-#{action}-text", :title => t_action(action))
    
    link_to(t_action(action), url, options)
  end

  def list_link_for(action, resource_or_model = nil, options = {})
    # Handle both symbols and strings
    action = action.to_s

    # Resource and Model setup
    # Support nested resources
    if resource_or_model.is_a? Array
      main_resource_or_model = resource_or_model.last
    else
      main_resource_or_model = resource_or_model
    end

    # Use controller name to guess resource or model if not specified
    case action
    when 'new', 'index'
      model = main_resource_or_model || controller_name.singularize.camelize.constantize
    when 'show', 'edit', 'delete'
      resource = main_resource_or_model || instance_variable_get("@#{controller_name.singularize}")
      model = resource.class
    end
    model_name = model.to_s.underscore

    # No link if CanCan is used and current user isn't authorized to call this action
    return if respond_to?(:can?) and cannot?(action.to_sym, model)

    # Link generation
    case action
    when 'index', 'show'
      path = polymorphic_path(resource_or_model)
    when 'delete'
      path = polymorphic_path(resource_or_model)
      options.merge!(:confirm => t_confirm_delete(main_resource_or_model), :method => :delete)
    else
      path = polymorphic_path(resource_or_model, :action => action)
    end

    return list_link_to(action, path, options)
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
