require_relative './wagon'

class CargoWagon
  attr_reader :type

  def initialize
    @type = "cargo"
  end
  
end