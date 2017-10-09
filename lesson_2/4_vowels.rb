vowels = {}
('a'..'z').each_with_index do |letter, index| 
  if letter == 'a' || letter == 'e' || letter == 'i' || letter == 'o' || letter == 'u' || letter == 'y'
    vowels[letter.to_sym] = index + 1
  end
end
print vowels