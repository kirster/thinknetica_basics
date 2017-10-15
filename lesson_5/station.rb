require_relative './instance_counter'

class Station

  include InstanceCounter

  attr_reader :title
  @@stations = []

  def initialize(title)
    @title = title
    @trains = []
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
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