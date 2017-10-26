require_relative './manufacturer'
require_relative './instance_counter'
require_relative './acessors'
require_relative './validation'

class Wagon
  include Manufacturer
  include InstanceCounter

  attr_reader :number

  def initialize(number)
    @number = number
    register_instance
  end
end
