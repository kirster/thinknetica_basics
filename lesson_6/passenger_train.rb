require_relative './train'

class PassengerTrain < Train
  attr_reader :type

  def initialize(train_id)
    super
    @type = "passenger"
  end
  
end