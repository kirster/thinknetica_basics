module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :rules

    def validate(var_name, validation_type, option = nil)
      @rules = []
      @rules << { var_name: var_name,
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
        send rule[:validation_type], rule[:var_name], rule[:option]
      end
      true
    end

    def presence(var_name, _option)
      if var_name.nil? || var_name.empty?
        raise 'Parameter can`t be nil or empty(for String class)'
      end
    end

    def type(var_name, option)
      raise 'Parameter has wrong type' unless var_name.is_a?(option)
    end

    def format(var_name, option)
      raise 'Parameter has wrong format' if var_name !~ option
    end
  end
end
