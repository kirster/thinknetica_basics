class Route
  attr_reader :stations, :route_code

  def initialize(initial_station, final_station)
    @route_code = "#{initial_station.title}_#{final_station.title}"
    @stations = [initial_station, final_station]
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  def add_station(station)
    @stations.insert(1, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  protected
  
    def validate!
      raise "Route should consist of station objects" unless stations.first.is_a?(Station) && stations.last.is_a?(Station)
    end
  
end