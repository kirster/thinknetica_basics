require_relative './wagon'

class PassengerWagon < Wagon
  attr_reader :type, :seats, :taken_seats

  def initialize(number, seats)
    super(number)
    @seats = seats
    validate!
    @taken_seats = 0
    @type = 'passenger'
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  def take_seat
    @taken_seats += 1 if remaining_seats > 0
  end

  def remaining_seats
    seats - taken_seats
  end

  protected

  def validate!
    raise 'Number can`t be nil' if number.nil?
    raise 'Seats number can not be 0 or negative' if seats <= 0
    true
  end
end
