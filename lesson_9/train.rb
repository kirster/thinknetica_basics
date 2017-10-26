require_relative './manufacturer'
require_relative './instance_counter'
require_relative './acessors'
require_relative './validation'

class Train
  include Manufacturer
  include InstanceCounter
  include Accessors
  include Validation

  attr_reader :train_id, :wagons, :speed

  @trains = {}

  class << self
    attr_reader :trains

    def add_train(train)
      @trains[train.train_id] = train
    end

    def find(train_id)
      @trains[train_id]
    end
  end

  def initialize(train_id)
    @train_id = train_id
    validate!
    @wagons = []
    @speed = 0
    self.class.add_train(self)
    register_instance
  end

  def train_created
    "Train #{train_id} created"
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    if @current_station_index == @route.stations.size - 1
      'Train is on the final station'
    else
      @route.stations[@current_station_index + 1]
    end
  end

  def previous_station
    if @current_station_index.zero?
      'Train is just on the first station'
    else
      @route.stations[@current_station_index - 1]
    end
  end

  def add_wagon(wagon)
    if @speed.zero? && wagon.type == type
      @wagons << wagon
    else
      'Impossible to make this operation, \
        while train is moving/Wrong wagon type'
    end
  end

  def remove_wagon(wagon)
    if @speed.zero? && !@wagons.empty?
      @wagons.delete(wagon)
    else
      'Impossible to make this operation, \
         while train is moving/Train has no wagons'
    end
  end

  def get_route(stations)
    @route = stations
    @current_station_index = 0
    current_station.receive_train(self)
  end

  def move_forward
    if @current_station_index == @route.stations.size - 1
      'Can`t go to the next station'
    else
      current_station.release_train(self)
      @current_station_index += 1
      current_station.receive_train(self)
    end
  end

  def move_backwards
    if @current_station_index.zero?
      'Can`t go to the previous station'
    else
      current_station.release_train(self)
      @current_station_index -= 1
      current_station.receive_train(self)
    end
  end

  def each_wagon
    @wagons.each { |wagon| yield(wagon) }
  end

  protected

  # The following methods are set as protected,
  # because they reflect inner work of a train.

  def increase_speed(delta = 10)
    @speed += delta
  end

  def stop
    @speed = 0
  end
end
