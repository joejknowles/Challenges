def solution(roman)
  value = {M:1000, D:500,C:100, L:50, X:10, V:5, I:1}
  roman = roman.chars
  num = 0
  roman.each_with_index do |n, i|
    if i == (roman.length - 1)
      num += value[n.to_sym]
    elsif value[n.to_sym] < value[roman[i+1].to_sym]
      num -= value[n.to_sym]
    else
      num += value[n.to_sym]
    end
  end
  num
end
puts solution('MDCLXVI')