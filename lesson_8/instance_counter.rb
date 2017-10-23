module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :amount

    def increase_amount
      @amount ||= 0
      @amount += 1
    end
  end

  module InstanceMethods
    protected

      def register_instance
        self.class.increase_amount
      end
  end
end
