def zen
  10.times do
    answer = 42 / 0
  end
end

begin
  puts "Calling zen."
  zen
end

puts "End of main."