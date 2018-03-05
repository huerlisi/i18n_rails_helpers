
module I18nRailsHelpers
  module ControllerHelpers
    delegate :t_attr, :t_model, :t_action, to: :helpers

    # returns a redirect notice for create, update and destroy actions
    #
    # Example in ClientsController:
    #   redirect_to some_path, redirect_notice           # => 'Klient geändert.'
    #   redirect_to some_path, redirect_notice(@client)  # => 'Klient Example Client geändert.'
    #
    def redirect_notice(record = nil)
      { notice: I18n.t("crud.notices.#{action_name}", model: helpers.t_model,
        record: record.present? ? "#{record} " : '') }
    end
  end
end
