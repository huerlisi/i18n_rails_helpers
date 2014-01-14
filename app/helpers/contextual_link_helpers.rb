module ContextualLinkHelpers
  # CRUD helpers
  def action_to_icon(action)
    case action.to_s
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
    when "update"
      "refresh"
    when "copy"
      "repeat"
    else
      action
    end
  end

  def icon_link_to(action, url = nil, options = {})
    classes = []
    if class_options = options.delete(:class)
      classes << class_options.split(' ')
    end

    classes << "btn"

    if action.is_a? Symbol
      url ||= {:action => action}
      title = t_action(action)
    else
      title = action
    end

    icon = options.delete(:icon)
    icon ||= action

    type = options.delete(:type)
    classes << "btn-#{type}" unless type.blank?

    options.merge!(:class => classes.join(" "))
    link_to(url_for(url), options) do
      content_tag(:i, "", :class => "icon-#{action_to_icon(icon)}") + " " + title
    end
  end

  def contextual_link_to(action, resource_or_model = nil, link_options = {})
    # We don't want to change the passed in link_options
    options = link_options.dup

    # Handle both symbols and strings
    action = action.to_sym

    # Resource and Model setup
    # Use controller name to guess resource or model if not specified
    case action
    when :new, :index
      model = resource_or_model || controller_name.singularize.camelize.constantize
    when :show, :edit, :delete
      resource = resource_or_model || instance_variable_get("@#{controller_name.singularize}")
      model = resource.class
    end
    model_name = model.to_s.underscore

    # No link if CanCan is used and current user isn't authorized to call this action
    return if respond_to?(:cannot?) and cannot?(action.to_sym, model)

    # Option generation
    case action
    when :delete
      options.merge!(:confirm => t_confirm_delete(resource), :method => :delete)
    end

    # Path generation
    case action
    when :index
      if model
        path = polymorphic_path(model)
      else
        path = url_for(:action => nil)
      end
    when :show, :delete
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

  def contextual_links_for(action = nil, resource_or_model = nil, options = {})
    # Use current action if not specified
    action ||= action_name

    # Handle both symbols and strings
    action = action.to_sym

    actions = []
    case action
    when :new, :create
      actions << :index
    when :show
      actions += [:edit, :delete, :index]
    when :edit, :update
      actions += [:show, :delete, :index]
    when :index
      actions << :new
    end

    links = actions.map{|link_for| contextual_link_to(link_for, resource_or_model, options)}

    return links.join("\n").html_safe
  end

  def contextual_links(action = nil, resource_or_model = nil, options = {})
    content_tag('div', :class => 'contextual') do
      contextual_links_for(action, resource_or_model, options)
    end
  end
end
