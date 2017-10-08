puts "Enter your name: "
name = gets.chomp.capitalize
puts "Enter your height: "
height = gets.chomp.to_i

perfect_weight = height - 110
if perfect_weight >= 0
  puts "#{name}, your perfect weight is #{perfect_weight}."
else
  puts "Your weight is already optimal."
end