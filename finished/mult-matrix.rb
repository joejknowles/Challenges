def matrix_mult(a, b)
  n = a.length
  final = []
  n.times { final << [] }
  final.each{|line| n.times{ line << 0}}
  (0...n).each do |y_fa|
    (0...n).each do |d|
      (0...n).each do |f|
        final[y_fa][d] += a[y_fa][f] * b[f][d]
      end
    end
  end
  final
end


puts "When n is four this method returns #{matrix_mult([[1, 2], [3, 2]], [[3, 2], [1, 1]])} which should be [[5, 4], [11, 8]] and means it works? #{matrix_mult([[1, 2], [3, 2]], [[3, 2], [1, 1]]) == [[5, 4], [11, 8]]}"

puts "When n is four this method returns #{matrix_mult([[1, 2, 3], [4, 5, 6], [7, 8 ,9]], [[1, 0, 0], [0, 1, 0], [0,0,1]])} which should be [[1, 2, 3], [4, 5, 6], [7, 8 ,9]] and means it works? #{matrix_mult([[1, 2, 3], [4, 5, 6], [7, 8 ,9]], [[1, 0, 0], [0, 1, 0], [0,0,1]]) == [[1, 2, 3], [4, 5, 6], [7, 8 ,9]]}"

puts "When n is four this method returns #{matrix_mult([[2, 0, -1], [3, 5, 2], [-4, 1 ,4]], [[5, 1, -2], [-1, 0, 4], [2,-3,3]])} which should be [[8, 5, -7], [14, -3, 20], [-13, -16 ,24]] and means it works? #{matrix_mult([[2, 0, -1], [3, 5, 2], [-4, 1 ,4]], [[5, 1, -2], [-1, 0, 4], [2,-3,3]]) == [[8, 5, -7], [14, -3, 20], [-13, -16 ,24]]}"