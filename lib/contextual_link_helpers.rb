module ContextualLinkHelpers
  # CRUD helpers
  def action_to_icon(action)
    case action
    when 'new'
      "plus"
    when 'show'
      "eye-open"
    when 'edit'
      "edit"
    when 'delete'
      "trash"
    when "index", "list"
      "list-alt"
    end
  end

  def icon_link_to(action, url = nil, options = {})
    url ||= {:action => action}
    options.merge!(:class => "btn")
    link_to(url_for(url), options) do 
      content_tag(:i, "", :class => "icon-#{action_to_icon(action)}") + " " + t_action(action)
    end
  end
  
  def contextual_link_to(action, resource_or_model = nil, options = {})
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
    return if respond_to?(:cannot?) and cannot?(action.to_sym, model)
    
    # Option generation
    case action
    when 'delete'
      options.merge!(:confirm => t_confirm_delete(resource), :method => :delete)
    end

    # Path generation
    case action
    when 'index'
      if model
        path = polymorphic_path(model)
      else
        path = url_for(:action => nil)
      end
    when 'show', 'delete'
      if resource
        path = polymorphic_path(resource)
      else
        return
      end
    else
      if resource_or_model
        path = polymorphic_path(resource_or_model, :action => action)
      else
        path = url_for(:action => action)
      end
    end

    return icon_link_to(action, path, options)
  end
  
  def contextual_links_for(action = nil, resource_or_model = nil)
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
  
  def contextual_links(action = nil, resource_or_model = nil)
    content_tag('div', :class => 'contextual') do
      contextual_links_for(action, resource_or_model)
    end
  end
end
