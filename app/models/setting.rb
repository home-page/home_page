class Setting < RailsSettings::CachedSettings
  attr_accessible :var, :value
  
  def cast_value
    if !value.is_a?(String)
      value
    elsif Setting.defaults[var].is_a?(Array) || Setting.defaults[var].is_a?(Hash)
      JSON.parse(value)
    elsif Setting.defaults[var].is_a?(Boolean)
      value == 'true'
    elsif Setting.defaults[var].is_a?(Fixnum)
      value.to_i
    elsif Setting.defaults[var].is_a?(Float)
      value.to_f
    elsif Setting.defaults[var].is_a?(Symbol)
      value.to_sym
    end
  end
end