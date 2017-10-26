require_relative './instance_counter'
require_relative './acessors'
require_relative './validation'

class Station
  include InstanceCounter
  include Accessors
  include Validation

  attr_reader :title
  
  @stations = []

  class << self
    def all
      @stations
    end

    def add_station(station)
      @stations << station
    end
  end

  def initialize(title)
    @title = title
    validate!
    @trains = []
    self.class.add_station(self)
    register_instance
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

  def each_train
    @trains.each { |train| yield(train) }
  end
end
