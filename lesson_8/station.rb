require_relative './instance_counter'

class Station
  include InstanceCounter

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

  def valid?
    validate!
  rescue RuntimeError
    false
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

  protected

  def validate!
    raise 'Station`s title can`t be nil' if title.nil?
    raise 'Station`s title should consist of 3 letters' if title.length < 3
    true
  end
end
