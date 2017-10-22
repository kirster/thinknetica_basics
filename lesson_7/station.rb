require_relative './instance_counter'

class Station

  include InstanceCounter

  attr_reader :title
  @@stations = []

  def initialize(title)
    @title = title
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def valid?
    validate!
  rescue
    false
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

  def each_train(&block)
    @trains.each { |train| block.call(train) }
  end

  protected

    def validate!
      raise "Station`s title can`t be nil" if title.nil?
      raise "Station`s title should consist at least 3 letters" if title.length < 3
      true
    end

end