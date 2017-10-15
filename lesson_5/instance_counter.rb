module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @amount = 0

    def amount
      @amount += 1
    end

  end

  module InstanceMethods
    protected
      def register_instance
        self.class.amount   
      end
  end
  
end