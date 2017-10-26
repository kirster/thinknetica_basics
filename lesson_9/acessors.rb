module Accessors
  def attr_accessor_with_history(*args)
    args.each do |var|
      var_name = "@#{var}".to_sym
      define_method(var.to_s) { instance_variable_get(var_name) }

      define_method("#{var}=") do |new_value|
        instance_variable_set(var_name, new_value)
        @history_values ||= Hash.new { |value, key| value[key] = [] }
        @history_values[var.to_s.to_sym] << new_value
      end

      define_method("#{var}_history") { @history_values[var.to_s.to_sym] }
    end
  end

  def strong_attr_acessor(var, type)
    var_name = "@#{var}".to_sym
    define_method(var) { instance_variable_get(var_name) }

    define_method("#{var}=") do |new_value|
      raise 'Wrong type' unless var.is_a?(type)
      instance_variable_set(var_name, new_value)
    end
  end
end
