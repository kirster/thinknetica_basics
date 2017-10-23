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
    '
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
    15 - show wagons of particular train
    -----------------------------
    16 - show trains on particular station
    -----------------------------
    17 - take seat in passenger wagon
    -----------------------------
    18 - take volume in cargo wagon
    '
  end

  def user_interface
    puts menu_message
    loop do
      puts 'Enter command: '
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
      when 15 then wagons_by_train
      when 16 then trains_by_station
      when 17 then take_seat
      when 18 then take_volume
      else puts 'Error.Wrong input'
      end
    end
    puts 'You exit the programm'
  end

  def create_station
    puts 'Enter station`s title: '
    title = gets.chomp
    Station.new(title)
  end

  def stations
    Station.all.each { |station| puts station.title }
  end

  def create_train
    begin
      puts 'Enter train`s id: '
      train_id = gets.chomp
      puts 'Enter type of train: '
      type = gets.chomp

      if type == 'passenger'
        PassengerTrain.new(train_id)
      else
        CargoTrain.new(train_id)
      end
    rescue RuntimeError => e
      puts e.message
      retry
    end
    puts Train.find(train_id).train_created
  end

  def trains
    Train.trains.each_key { |train_id| puts train_id }
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
    wagon = configure_wagon(train)
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

  def wagons_by_train
    train = select_train
    block = create_block(train.type)
    train.each_wagon(&block)
  end

  def each_train_on_station
    station = select_station
    block = lambda do |train|
      puts "Train #{train.train_id} : #{train.type}, #{train.wagons.size}"
    end
    station.each_train(&block)
  end

  def take_seat
    train = select_train
    wagon = select_wagon(train)
    wagon.take_seat
  end

  def take_volume
    train = select_train
    wagon = select_wagon(train)
    wagon.take_volume
  end

  private

  # The following methods are private, because they are helpers for interface.

  def select_station
    puts 'Enter station`s title: '
    title = gets.chomp
    Station.all.select { |station| station.title == title }[0]
  end

  def select_route
    puts 'Enter route code: '
    route_code = gets.chomp
    @routes.select { |route| route.route_code == route_code }[0]
  end

  def select_train
    puts 'Enter train id: '
    train_id = gets.chomp
    Train.find(train_id)
  end

  def configure_wagon(train)
    puts 'Enter number of wagon: '
    number = gets.chomp.to_i

    if train.type == 'passenger'
      puts 'Enter number of seats:'
      seats = gets.chomp.to_i
      PassengerWagon.new(number, seats)
    else
      puts 'Enter volume:'
      volume = gets.chomp.to_i
      CargoWagon.new(number, volume)
    end
  end

  def select_wagon(train)
    puts 'Enter number of wagon:'
    number = gets.chomp.to_i
    train.wagons[number]
  end

  def create_block(type)
    if type == 'cargo'
      lambda do |wagon|
        puts "Wagon #{wagon.number} : #{wagon.type}, \
              #{wagon.remaining_volume}, #{wagon.taken_volume}"
      end
    else
      lambda do |wagon|
        puts "Wagon #{wagon.number} : #{wagon.type}, \
              #{wagon.remaining_seats}, #{wagon.taken_seats}"
      end
    end
  end
end

programm = Main.new
programm.user_interface
