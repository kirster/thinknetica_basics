class Route
  attr_reader :stations, :route_code

  def initialize(initial_station, final_station)
    @route_code = "#{initial_station.title}_#{final_station.title}"
    @stations = [initial_station, final_station]
    validate!
  end

  def valid?
    validate!
  rescue RuntimeError
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
    expr_one = stations.first.is_a?(Station)
    expr_two = stations.last.is_a?(Station)
    raise 'Route should consist of station objects' unless expr_one && expr_two
  end
end
