require_relative './wagon'
require_relative './acessors'
require_relative './validation'

class CargoWagon < Wagon
  include Accessors
  include Validation

  attr_reader :type, :volume, :taken_volume

  def initialize(number, volume)
    super(number)
    @volume = volume
    validate!
    @taken_volume = 0
    @type = 'cargo'
  end

  def take_volume(delta)
    @taken_volume += delta if remaining_volume > delta
  end

  def remaining_volume
    volume - taken_volume
  end
end
