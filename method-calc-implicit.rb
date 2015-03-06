def zero
  return 0 unless block_given?
  yield 0
end
def one
  return 1 unless block_given?
  yield 1
end
def two
  return 2 unless block_given?
  yield 2
end
def three
  return 3 unless block_given?
  yield 3
end
def four
  return 4 unless block_given?
  yield 4
end
def five
  return 5 unless block_given?
  yield 5
end
def six
  return 6 unless block_given?
  yield 6
end
def seven
  return 7 unless block_given?
  yield 7
end
def eight
  return 8 unless block_given?
  yield 8
end
def nine
  return 9 unless block_given?
  yield 9
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
end

puts one &plus(one)
puts five &times(two)
puts seven &minus(one)
puts one &divided_by(one)
puts two &divided_by(seven)
puts three &plus(five)
puts nine &times(nine)
puts seven &minus(seven)
puts four &divided_by(four)
puts six &divided_by(three)
