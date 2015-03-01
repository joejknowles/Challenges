def get_function(*sequence)
  a = sequence[1] - sequence[0]
  c = sequence[0]
  sin = c
  if sequence[-1] != (sequence[-2] + a)
    return'Non-linear sequence'
  elsif c == 0
    c=""
  elsif c < 0
    c = " - #{-c}"
  elsif c>0
    c = " + #{c}"
  end

  if a == 1
    a="x"
  elsif a == -1
    a="-x"
  elsif a == 0
    a=''
    if sin > 0
      c = sin
    elsif sin < 0
      c = "- #{-sin}"
    end
  else
    a="#{a}x"
  end
  "f(x) = #{a}#{c}"
end
puts get_function(1, 0, -1, -2, -3)
puts get_function(0, 3, 6, 9, 12)
puts get_function(1, 4, 7, 10, 13)
puts get_function(1, 2, 4, 7, 11)