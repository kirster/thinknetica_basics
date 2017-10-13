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
    @trains.any? ? @trains : "No trains on station #{self.title}"
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }.size if @trains.any?
  end

  def release_train(train)
    @trains.include?(train) ? @trains.delete(train) : "No such train on station #{self.title}" 
  end

end


class Route
  attr_reader :stations

  def initialize(initial_station, final_station)
    @stations = [initial_station, final_station]
  end

  def add_station(station)
    @stations.insert(1, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
  
end


class Train
  attr_reader :train_id, :type, :number_of_wagons, :speed 

  def initialize(train_id, type, number_of_wagons=0)
    @train_id = train_id
    @type = type
    @number_of_wagons = number_of_wagons
    @speed = 0
  end

  def increase_speed(delta=10)
    @speed += delta
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @speed == 0 ? @number_of_wagons += 1 : "Impossible to make this operation, while train is moving"  
  end

  def remove_wagon
    @speed == 0 && @number_of_wagons > 0 ? @number_of_wagons -= 1 : 
                                        "Impossible to make this operation, while train is moving/Train has no wagons"
  end

  def get_route(stations)
    @route = stations
    @current_station_index = 0
    current_station.receive_train(self)
  end

  def move_forward
    unless @current_station_index == @route.stations.size - 1
      current_station.release_train(self)
      @current_station_index += 1
      current_station.receive_train(self)
    else
      "Can`t go to the next station"
    end
  end

  def move_backwards
    unless @current_station_index == 0
      current_station.release_train(self)
      @current_station_index -= 1
      current_station.receive_train(self)
    else
      "Can`t go to the previous station"
    end
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @current_station_index == @route.stations.size - 1 ? "Train is on the final station" : 
                                                        @route.stations[@current_station_index + 1]
  end

  def previous_station
    @current_station_index == 0 ? "Train is just on the first station" : @route.stations[@current_station_index - 1]
  end

end