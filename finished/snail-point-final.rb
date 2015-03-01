def snail(array)
  n = array.length
  final = []
  coords = [-1 , 0]
  switch = false
  switch2 = true
  until n == 0
    n.times do
      switch2 ? coords[0] += 1 : coords[0] -= 1
      switch ? final << array[coords[0]][coords[1]] : final << array[coords[1]][coords[0]]
    end
    switch = !switch
    switch ? n -= 1 : switch2 = !switch2
    coords = coords.reverse
  end
  final
end


puts "3*3 array returns:\n #{snail([['uno',2,3],
                                 [8,'nueve',4],
                                 ['siete',6,5]])}"

puts "4*4 array returns:\n #{snail([[ 1, 'hi', 3,4],
                                 [12,13,14,5],
                                 [11,16,15,6],
                                 [10, 9, 8,7]])}"

puts "5*5 array returns:\n #{snail([[ 1, 2, 3, 4, 5],
                                 [16,17,18,19, 6],
                                 [15,24,25,20, 7],
                                 [14,23,22,21, 8],
                                 [13,12,11,10, 9]])}"
