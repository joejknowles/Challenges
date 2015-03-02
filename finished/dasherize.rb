def dasherize_number(number)
  clean_ends(add_dashes(number.to_s.chars)).join
end

def add_dashes(digits)
  digits.inject([]) do |array, digit|
    array.push("-") if digit.to_i % 2 == 1 && array[-1] != '-'
    array.push(digit)
    digit.to_i % 2 == 1 ? array.push("-") : array
  end
end

def clean_ends(dashes_added)
  dashes_added.shift if dashes_added[0] == '-'
  dashes_added.pop if dashes_added[-1] == '-'
  dashes_added
end

puts dasherize_number(1217668322425623)

