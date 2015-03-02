def snail(array)
  n = array.length
  #n % 2 == 0 ? end_coord = : end_coord = [n/2+1, n/2+1]
  final = []
  x,y= 0 ,0
  switch = false
  n.times do
    final.push(array[y][x])
    puts "x = #{x}, y = #{y}, n = #{n}, switch = #{switch}"
    puts "Final array is #{final}."

    x += 1
  end
  switch = !switch
  x -= 1
  n -= 1 if switch
  n.times do
    y += 1
    final.push(array[y][x])
    puts "x = #{x}, y = #{y}, n = #{n}, switch = #{switch}"
    puts "Final array is #{final}."

  end
  switch = !switch
  n -= 1 if switch
  n.times do
    x -= 1
    final.push(array[y][x])
    puts "x = #{x}, y = #{y}, n = #{n}, switch = #{switch}"
    puts "Final array is #{final}."

  end
  switch = !switch
  n -= 1 if switch
  n.times do
    y -= 1
    final.push(array[y][x])
    puts "x = #{x}, y = #{y}, n = #{n}, switch = #{switch}"
    puts "Final array is #{final}."

  end
  switch = !switch

  puts "Final *FINAL* array is #{final}."
end

snail([[1,2,3],
       [8,9,4],
       [7,6,5]])