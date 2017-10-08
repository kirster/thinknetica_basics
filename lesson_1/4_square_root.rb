puts "Enter coefficient a: "
a = gets.chomp.to_f
puts "Enter coefficient b: "
b = gets.chomp.to_f
puts "Enter coefficient c: "
c = gets.chomp.to_f


discriminant = b ** 2 - 4 * a * c
if discriminant > 0
  root_1 = (-b + Math.sqrt(discriminant)) / (2 * a)
  root_2 = (-b - Math.sqrt(discriminant)) / (2 * a)
  puts "Discriminant: #{discriminant}, first root: #{root_1}, second root: #{root_2}"
elsif discriminant < 0
  puts "No roots"
else
  puts "Discriminant: #{discriminant}, root: #{-b / (2 * a)}"
end  