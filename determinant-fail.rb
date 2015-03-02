def determinant(matrix)
  @matrix = matrix
  @n = matrix.length
  (0..1).inject(0) do |det, xCoord|
    det += pos_diag(xCoord)
    puts "det #{det}, xCoord #{xCoord}"
    det -= neg_diag(xCoord)
  end
end

def pos_diag(xCo)
  puts 'start pos diag'
  (0...@n).inject(1) do |product, row|
    puts "here the element being multiplied is #{@matrix[row][xCo]}"
    product *= @matrix[row][xCo]
    xCo-=1
    product
  end
end
def neg_diag(xCoord)
  0
end

m1 = [ [1, 3],
       [2, 5]]
m2 = [ [2, 5, 3],
       [1,-2,-1],
       [1, 3, 4]]

puts "first returns #{determinant(m1)}, meaning it's #{determinant(m1)==-1} that determinant(m1)==-1"

puts "first returns #{determinant(m2)}, meaning it's #{determinant(m2)==-20} that determinant(m2)==-20"
