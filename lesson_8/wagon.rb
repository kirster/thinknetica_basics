require_relative './manufacturer'
require_relative './instance_counter'

class Wagon
  include Manufacturer
  include InstanceCounter

  attr_reader :number

  def initialize(number)
    @number = number
    register_instance
  end
end
