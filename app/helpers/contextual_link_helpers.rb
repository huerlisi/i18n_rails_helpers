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

    classes << I18nRailsHelpers.contextual_link_class

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
      boot_icon(action_to_icon(icon)) + " " + title
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
      default_model = controller_name.singularize.camelize.constantize
      model = resource_or_model || default_model
      explicit_resource_or_model = default_model != model
    when :show, :edit, :delete, :destroy
      default_resource = instance_variable_get("@#{controller_name.singularize}")
      resource = resource_or_model || default_resource
      model = resource.class
      explicit_resource_or_model = default_resource != resource
    end
    model_name = model.to_s.underscore

    unless resource_or_model.is_a?(String)
      # No link if CanCan is used and current user isn't authorized to call this action
      return if respond_to?(:cannot?) and cannot?(action.to_sym, model)
    end

    # Option generation
    case action
    when :delete, :destroy
      options.merge!(:confirm => t_confirm_delete(resource), :method => :delete)
    end

    begin
      if resource_or_model.is_a?(String)
        path = resource_or_model
      else
        # Path generation
        case action
        when :index
          if explicit_resource_or_model
            path = polymorphic_path(model)
          else
            path = url_for(:action => nil)
          end
        when :delete, :destroy
          if explicit_resource_or_model
            path = polymorphic_path(resource)
          else
            path = url_for(:action => :destroy)
          end
        else
          if explicit_resource_or_model
            path = polymorphic_path(resource_or_model, :action => action)
          else
            path = url_for(:action => action)
          end
        end
      end

      return icon_link_to(action, path, options)

    rescue ActionController::UrlGenerationError
      # This handles cases where we did exclude crud actions in the routing map.
    end
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
      actions += [:edit, :destroy, :index]
    when :edit, :update
      actions += [:show, :destroy, :index]
    when :index
      actions << :new
    end

    links = actions.map{|link_for| contextual_link_to(link_for, resource_or_model, options)}

    return links.join("\n").html_safe
  end

  def contextual_links(action = nil, resource_or_model = nil, options = {}, &block)
    content_tag('div', :class => I18nRailsHelpers.contextual_class) do
      content = contextual_links_for(action, resource_or_model, options)
      if block_given?
        additional_content = capture(&block)
        content += ("\n" + additional_content).html_safe unless additional_content.nil?
      end
      content
    end
  end
end
