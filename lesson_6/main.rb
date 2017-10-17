require_relative './train'
require_relative './passenger_train'
require_relative './cargo_train'
require_relative './wagon'
require_relative './passenger_wagon'
require_relative './cargo_wagon'
require_relative './route'
require_relative './station'

class Main

  def initialize
    @routes = []
  end

  def menu_message
    %q(
    0 - exit programm
    -----------------------------  
    1 - create station
    -----------------------------
    2 - list of stations
    -----------------------------
    3 - create train
    -----------------------------
    4 - list of trains
    -----------------------------
    5 - show trains by station
    -----------------------------
    6 - create route
    -----------------------------
    7 - list of routes
    -----------------------------
    8 - add station to route
    -----------------------------
    9 - remove station from route
    -----------------------------
    10 - set route to train
    -----------------------------
    11 - add wagon to train
    -----------------------------
    12 - remove wagon from train
    -----------------------------
    13 - move train forward
    -----------------------------
    14 - move train backwards
    -----------------------------
    )
  end

  def user_interface
    puts menu_message
    loop do
      puts "Enter command: "
      response = gets.chomp.to_i
      case response
        when 0 then break
        when 1 then create_station
        when 2 then stations
        when 3 then create_train
        when 4 then trains
        when 5 then trains_by_station  
        when 6 then create_route
        when 7 then routes
        when 8 then add_station  
        when 9 then remove_station
        when 10 then set_route
        when 11 then add_wagon
        when 12 then remove_wagon
        when 13 then move_forward  
        when 14 then move_backwards
        else puts "Error.Wrong input"      
      end
    end
    puts "You exit the programm"     
  end

  def create_station
    puts "Enter station`s title: "
    title = gets.chomp
    Station.new(title)
  end

  def stations
    Station.all.each { |station| puts station.title }
  end

  def create_train
    begin
      puts "Enter train`s id: "
      train_id = gets.chomp
      puts "Enter type of train: "
      type = gets.chomp
      type == "passenger" ? PassengerTrain.new(train_id) : CargoTrain.new(train_id)
    rescue RuntimeError => e
      puts e.message
      retry
    end
    puts Train.find(train_id).train_created
  end

  def trains
    Train.trains.keys.each { |train_id| puts train_id }
  end

  def trains_by_station
    station = select_station
    station.trains.each { |train| puts train.train_id }
  end

  def create_route
    initial_station = select_station
    final_station = select_station
    @routes << Route.new(initial_station, final_station)
  end

  def routes
    @routes.each { |route| puts route.route_code }
  end

  def add_station
    route = select_route
    route.add_station(select_station)
  end

  def remove_station
    route = select_route
    route.delete_station(select_station)
  end

  def set_route
    train = select_train
    train.get_route(select_route)
  end

  def add_wagon
    train = select_train
    wagon = train.type == "passenger" ? PassengerWagon.new() : CargoWagon.new()
    train.add_wagon(wagon)
  end

  def remove_wagon
    train = select_train
    wagon = train.wagons[-1]
    train.remove_wagon(wagon)
  end

  def move_forward
    train = select_train
    train.move_forward
  end

  def move_backwards
    train = select_train
    train.move_backwards
  end

  private
    # The following methods are private, because they are helpers for interface.

    def select_station
      puts "Enter station`s title: "
      title = gets.chomp
      Station.all.select { |station| station.title == title }[0]
    end

    def select_route
      puts "Enter route code: "
      route_code = gets.chomp
      @routes.select { |route| route.route_code == route_code }[0]
    end

    def select_train
      puts "Enter train id: "
      train_id = gets.chomp
      Train.find(train_id)
    end
 
end

programm = Main.new
programm.user_interface                  