require_relative './train'

class CargoTrain < Train
  attr_reader :type

  def initialize(train_id)
    super
    @type = 'cargo'
  end
end
