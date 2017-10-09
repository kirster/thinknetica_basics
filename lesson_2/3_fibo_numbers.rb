fibo_numbers = [0, 1]
until fibo_numbers[-1] == 89
  fibo_numbers << fibo_numbers[-2] + fibo_numbers[-1]
end
print fibo_numbers