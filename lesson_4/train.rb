class Train
  attr_reader :train_id, :wagons, :speed 

  def initialize(train_id)
    @train_id = train_id
    @wagons = []
    @speed = 0
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

  def add_wagon(wagon)
    @speed == 0 && wagon.type == self.type ? @wagons << wagon : 
                                          "Impossible to make this operation, while train is moving/Wrong wagon type"  
  end

  def remove_wagon(wagon)
    @speed == 0 && @wagons.size > 0 ? @wagons.delete(wagon) : 
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

  protected
    # The following methods are set as protected, because they reflect inner work of a train.

    def increase_speed(delta=10)
      @speed += delta
    end

    def stop
      @speed = 0
    end

end