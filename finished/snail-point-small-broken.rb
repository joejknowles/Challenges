def snail(array)
  n = array.length # N will be the distance to traverse accross rows and collumns. It starts at array.length and decreases by one on every even iteration.
  final = [] #Where the final array will be
  coords = [-1 , 0] # At the beginning coords[0] is x and coords[1] is y. They signify the coordinates of the next 2d array element to be pushed. Starts x at -1  and y at 0. each time
  switch = false #Switch for whether to reduce n
  switch2 = true #switch between coord+=1 and coord-=1
  #redundant z = 0 #switch for switch two to only change alternately
  while n > 0
    n.times do
      switch2 ? coords[0] += 1 : coords[0] -= 1 #every other iteration swap between '+' and '-' operators
      final << array[coords[1]][coords[0]] # Pushes current element to final array
    end
    switch = !switch
    switch ? n -= 1 : switch2 = !switch2
    return final if n == 0
    coords = coords.reverse #EVERY iteration x and y swap
  end
end


puts "3*3 array returns #{snail([['uno',2,3],
                                 [8,'nueve',4],
                                 ['siete',6,5]])}"

puts "4*4 array returns #{snail([[ 1, 'hi', 3,4],
                                 [12,13,14,5],
                                 [11,16,15,6],
                                 [10, 9, 8,7]])}"

puts "5*5 array returns #{snail([[ 1, 2, 3, 4, 5],
                                 [16,'this',18,19, 'that'],
                                 [15,24,25,20, 7],
                                 [14,23,22,21, 8],
                                 [13,12,11,10, 9]])}"
