module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :rules

    def validate(var_name, validation_type, option = nil)
      @rules ||= []
      @rules << { var_properties: { var_name: var_name, 
                                    var_value: instance_variable_get("@#{var_name}") },
                  validation_type: validation_type.to_sym,
                  option: option }
    end
  end

  module InstanceMethods
    def valid?
      validate!
    rescue RuntimeError
      false
    end

    def validate!
      self.class.rules.each do |rule|
        send rule[:validation_type], rule[:var_properties], rule[:option]
      end
      true
    end

    def presence(var_properties, _option)
      if var_properties[:var_value].nil? || var_properties[:var_value].empty?
        raise "Parameter #{var_properties[:var_name]} \
              can`t be nil or empty(for String class)"
      end
    end

    def type(var_properties, option)
      unless var_properties[:var_value].is_a?(option)
        raise "Parameter #{var_properties[:var_name]} has wrong type"
      end
    end

    def format(var_properties, option)
      if var_properties[:var_value] !~ option
        raise "Parameter #{var_properties[:var_name]} has wrong format"
      end
    end
  end
end
