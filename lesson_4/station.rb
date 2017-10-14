class Station
  attr_reader :title

  def initialize(title)
    @title = title
    @trains = []
  end

  def receive_train(train)
    @trains << train
  end

  def trains
    @trains if @trains.any?
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }.size if @trains.any?
  end

  def release_train(train)
    @trains.delete(train) if @trains.include?(train)
  end

end