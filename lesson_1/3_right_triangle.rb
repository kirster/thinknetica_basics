sides = []
3.times do
  puts "Enter triangle`s side length: "
  sides << gets.chomp.to_f
end
sides.sort!

if sides[0] == sides[1] && sides[1] == sides[2]
  puts "Equilateral and isosceles triangle"
elsif sides[2] ** 2 == sides[0] ** 2 + sides[1] ** 2
  print "Right triangle "
  if sides[0] == sides[1]
    puts " and isosceles triangle"
  end
elsif sides[0] == sides[1] || sides[1] == sides[2]
  puts "Isosceles triangle"
else
  puts "Not a specific triangle"
end