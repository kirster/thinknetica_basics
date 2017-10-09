cart = {}
loop do
  puts "Enter item you bought('stop' to exit): "
  item = gets.chomp
  break if item == "stop"
  if cart[item].nil?  
    puts "Enter price for one item: "
    price = gets.chomp.to_f
    puts "Enter item amount: "
    amount = gets.chomp.to_f
    cart[item] = {price: price, amount: amount}
  else
    puts "Item is already in your cart"
  end
end
puts cart

total = 0
cart.each do |product, data|
  item_total = data[:price] * data[:amount]
  puts "#{product}: #{item_total} dollars"
  total += item_total
end
puts "Total: #{total} dollars"