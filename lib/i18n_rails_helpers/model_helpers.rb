module I18nRailsHelpers
  module ModelHelpers
    # enum attrubute_t and attributes_t return translated enum values
    #
    # Example:
    #   in the Client model
    #     enum gender: { undefined: 0, female: 1, male: 2 }
    #   in use
    #     Client.first.gender    # => 'female'
    #     Client.first.gender_t  # => 'Frau'
    #     Client.first.genders_t # => { undefined: 'Nicht definiert', female: 'Frau', male: 'Mann' }
    #
    # Requires:
    #   locale key: activerecord.attributes.#{model_name}.#{enum}.#{enum_value_key}
    #   eg.:        activerecord.attributes.client.genders.female                    # => 'Frau'
    #
    def define_enum_t_methods
      defined_enums.each do |enum_attr, values|
        self.class.send(:define_method, "#{enum_attr}_t") { t_enum(enum_attr) }
        self.class.send(:define_method, "#{enum_attr.pluralize}_t") do
          public_send(:t_enum_values, enum_attr, values)
        end
      end
    end

    def t_enum_values(enum_attr, values)
      values.map do |enum_val_key, _|
        [enum_val_key.to_sym, t_enum(enum_attr, enum_val_key)]
      end.to_h
    end

    # translate enum fields value
    def t_enum(enum_attr, enum_value = nil)
      enum_value ||= public_send(enum_attr)
      I18n.t(
        "activerecord.attributes.#{model_name.i18n_key}.#{enum_attr.to_s.pluralize}.#{enum_value}"
      )
    end
  end
end
