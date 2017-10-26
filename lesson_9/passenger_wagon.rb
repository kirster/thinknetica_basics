require_relative './wagon'
require_relative './acessors'
require_relative './validation'

class PassengerWagon < Wagon
  include Accessors
  include Validation
  
  attr_reader :type, :seats, :taken_seats

  def initialize(number, seats)
    super(number)
    @seats = seats
    validate!
    @taken_seats = 0
    @type = 'passenger'
  end

  def take_seat
    @taken_seats += 1 if remaining_seats > 0
  end

  def remaining_seats
    seats - taken_seats
  end
end
