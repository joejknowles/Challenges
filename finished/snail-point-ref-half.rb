def snail(array)
  n = array.length # N will be the distance to traverse accross rows and collumns. It starts at array.length and decreases by one on every even iteration.
  final = [] #Where the final array will be
  x,y= -1 ,0 # x and y signify the coordinates of the next 2d array element to be pushed. Starts x at -1  and y at 0
  switch = false
  switch2 = true
  while n > 0
    #ONE ==================================================
    n.times do
      switch2 ? x += 1 : x -= 1
      final.push(array[y][x])
    end

    switch = !switch
    n -= 1 if switch
    return final if n == 0

    #TWO ==================================================
    n.times do
      switch2 ? y += 1 : y -= 1
      final.push(array[y][x])
    end

    switch = !switch
    n -= 1 if switch
    return final if n == 0
    #==================================================
    switch2 = !switch2
  end

=begin    #THREE ==================================================
    n.times do
      x -= 1
      final.push(array[y][x])
    end

    switch = !switch
    n -= 1 if switch
    return final if n == 0
    #FOUR ==================================================
    n.times do
      y -= 1
      final.push(array[y][x])
    end
    switch = !switch
    n -= 1 if switch
    return final if n == 0
    #==================================================
  end
=end
end

puts "3*3 array returns #{snail([[1,2,3],
                                 [8,9,4],
                                 [7,6,5]])}"

puts "4*4 array returns #{snail([[ 1, 2, 3,4],
                                 [12,13,14,5],
                                 [11,16,15,6],
                                 [10, 9, 8,7]])}"

puts "5*5 array returns #{snail([[ 1, 2, 3, 4, 5],
                                 [16,'this',18,19, 'that'],
                                 [15,24,25,20, 7],
                                 [14,23,22,21, 8],
                                 [13,12,11,10, 9]])}"

#      puts "x = #{x}, y = #{y}, n = #{n}, switch = #{switch}"
#      puts "Final array is #{final}."