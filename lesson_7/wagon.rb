require_relative './manufacturer'
require_relative './instance_counter'

class Wagon

  attr_reader :number

  include Manufacturer
  include InstanceCounter

  def initialize(number)
    @number = number
    register_instance
  end
  
end