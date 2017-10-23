require_relative './wagon'

class CargoWagon < Wagon
  attr_reader :type, :volume, :taken_volume

  def initialize(number, volume)
    super(number)
    @volume = volume
    validate!
    @taken_volume = 0
    @type = 'cargo'
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  def take_volume(delta)
    @taken_volume += delta if remaining_volume > delta
  end

  def remaining_volume
    volume - taken_volume
  end

  protected

  def validate!
    raise 'Number can`t be nil' if number.nil?
    raise 'Volume can not be 0 or negative' if volume <= 0
    true
  end
end
