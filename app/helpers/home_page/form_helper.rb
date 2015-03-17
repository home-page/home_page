module HomePage
  module FormHelper
    def setting_input(f, var, options = {})
      required = options.delete(:required) || false
      label = options.delete(:label)
      
      default = Setting.defaults[var]
      hint_value = default.is_a?(Array) || default.is_a?(Hash) ? default.to_json : default.inspect
      value = @settings[var].try(:value)
      value = if value.nil?
        value
      else
        default.is_a?(Array) || default.is_a?(Hash) ? value.to_json : value
      end
      
      f.input(
        var, label: label || t("settings.vars.#{var}"), input_html: { id: var.gsub(/\./, '_'), value: value },
        hint: Setting.defaults[var].nil? ? nil : t('settings.index.default_value', value: hint_value),
        required: required
      )
    end
  end
end