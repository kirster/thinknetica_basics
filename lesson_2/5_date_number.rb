months = { january: 31, february: 28,
            march: 31, april: 30, may: 31,
            june: 30, july: 31, august: 31, 
            september: 30, october: 31, november: 30, december: 31 }

puts "Enter day:"
day_number = gets.chomp.to_i
puts "Enter month:"
month_number = gets.chomp.to_i
puts "Enter year:"
year = gets.chomp.to_i

months[:february] = 29 if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
months = months.to_a

date = 0
(month_number - 1).times {|i| date += months[i][1]}
date += day_number
puts date