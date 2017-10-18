class Route
  attr_reader :stations, :route_code

  def initialize(initial_station, final_station)
    @route_code = "#{initial_station.title}_#{final_station.title}"
    validate!
    @stations = [initial_station, final_station]
  end

  def valid?
    validate!
  rescue
    false
  end

  def validate!
    raise "Route should consist of station objects" unless initial_station.is_a?(Station) && final_station.is_a?(Station)
  end

  def add_station(station)
    @stations.insert(1, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
  
end