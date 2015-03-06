def zero(operation=nil)
  return 0 if operation.nil?
  operation.call(0)
end
def one(operation=nil)
  return 1 if operation.nil?
  operation.call(1)
end
def two(operation=nil)
  return 2 if operation.nil?
  operation.call(2)
end
def three(operation=nil)
  return 3 if operation.nil?
  operation.call(3)
end
def four(operation=nil)
  return 4 if operation.nil?
  operation.call(4)
end
def five(operation=nil)
  return 5 if operation.nil?
  operation.call(5)
end
def six(operation=nil)
  return 6 if operation.nil?
  operation.call(6)
end
def seven(operation=nil)
  return 7 if operation.nil?
  operation.call(7)
end
def eight(operation=nil)
  return 8 if operation.nil?
  operation.call(8)
end
def nine(operation=nil)
  return 9 if operation.nil?
  operation.call(9)
end
def plus(num)
  lambda { |other_num| other_num + num}
end
def minus(num)
  lambda { |other_num| other_num - num}
end
def times(num)
  lambda { |other_num| other_num * num}
end
def divided_by(num)
  lambda { |other_num| other_num / num}
rescue ZeroDivisionError
 puts "You can't divide by zero"
end

puts one(plus(one))
puts five(times(two))
puts seven(minus(one))
puts one(divided_by(one))
puts one(divided_by(seven))

puts one(lambda { |other_num| other_num + 1})