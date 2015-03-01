def solution(n)
  length = n.to_s.length
  n = n.to_s.chars.each_with_index.map{|x, i| ( length - i -1 ) % 3 == 0 ? x << ',' : x }
  n[-1] = n[-1].chars
  n = n.flatten
  n.pop if n[-1] == ','
  n.join('')
end

puts solution(1005038364528394856353786742000889880990)