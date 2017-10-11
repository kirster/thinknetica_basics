class Station
  attr_reader :title

  def initialize(title)
    @title = title
    @trains = []
  end

  def receive_train(train)
    @trains << train
  end

  def display_trains
    if @trains.any?
      output = "Station #{self.title}: \n"
      @trains.each { |train| output += "\t Train #{train.train_id} \n" }
      output
    else
      "No trains on station #{self.title}"
    end
  end

  def display_trains_by_type
    if @trains.any?
      passenger_trains = 0
      cargo_trains = 0
      @trains.each { |train| if train.type == "passenger" then passenger_trains += 1 else cargo_trains += 1 end}
      "Station #{self.title}: #{passenger_trains} passenger train(s) and #{cargo_trains} cargo train(s)"
    else
      "No trains on station #{self.title}"
    end
  end

  def release_train(train)
    if @trains.include?(train)
      @trains.delete(train)
      "Train #{train.train_id} is leaving station #{self.title}"
    else
      "No such train on station #{self.title}"
    end  
  end

end


class Route
  attr_reader :route

  def initialize(initial_station, final_station)
    @route = [initial_station, final_station]
  end

  def add_station(station)
    @route.insert(1, station)
  end

  def delete_station(station)
    @route.delete(station)
  end

  def display_stations
    output = "The entire route is: \n"
    @route.each { |station| output += "#{station.title} \n" }
    output
  end
  
end


class Train
  attr_reader :train_id, :type 

  def initialize(train_id, type, number_of_wagons=0)
    @train_id = train_id
    @type = type
    @number_of_wagons = number_of_wagons
    @speed = 0
  end

  def display_current_speed
    "Current speed: #{@speed}"
  end

  def increase_speed(delta=10)
    @speed += delta
  end

  def stop
    @speed = 0
  end

  def display_number_of_wagons
    "This train has #{@number_of_wagons} wagons"
  end

  def add_or_remove_wagons(add=true)
    if @speed == 0
      add ? @number_of_wagons += 1 : @number_of_wagons -= 1
    else
      "Impossible to make this operation, while train is moving"  
    end
  end

  def get_route(route)
    @path = route
    @current_station_index = 0
    @current_station = @path.route[@current_station_index]
  end

  def move(forward=true)
    if forward
      @current_station_index != @path.route.size - 1 ? @current_station_index += 1 : "Can`t go to the next station"
    else
      @current_station_index != 0 ? @current_station_index -= 1 : "Can`t go to the previous station"
    end 
  end

  def display_current_station
    "Current station: #{@path.route[@current_station_index].title}"
  end

  def display_next_station
    @current_station_index == @path.route.size - 1 ? "Train is on the final station" : "Next station: #{@path.route[@current_station_index + 1].title}"
  end

  def display_previous_station
    @current_station_index == 0 ? "Train is just on the first station" : "Previous station: #{@path.route[@current_station_index - 1].title}"
  end

end