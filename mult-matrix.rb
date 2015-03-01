def matrix_mult(a, b)
  count = 0
  n = a.length
  final = []
  c, d, e, f, g, h =0,0,0,0,0,0
  n.times { final << [] }
  final.each{|line| n.times{ line << 0}}
  n.times do
    n.times do
      n.times do
        count += 1
        final[c][d] += a[e][f] * b[g][h]
        f+=1
        g+=1
      end
      d+=1
      h+=1
      f = 0 if f % n == 0
      g = 0 if g % n == 0
      h = 0 if h % n == 0
      d = 0 if d % n == 0
    end
    e += 1
    c += 1
    c = 0 if c % n == 0
    e = 0 if e % n == 0
  end
  final
end





puts "When n is four this method returns #{matrix_mult([[1, 2], [3, 2]], [[3, 2], [1, 1]])} which should be [[5, 4], [11, 8]] and means it works? #{matrix_mult([[1, 2], [3, 2]], [[3, 2], [1, 1]]) == [[5, 4], [11, 8]]}"

puts "When n is four this method returns #{matrix_mult([[1, 2, 3], [4, 5, 6], [7, 8 ,9]], [[1, 0, 0], [0, 1, 0], [0,0,1]])} which should be [[1, 2, 3], [4, 5, 6], [7, 8 ,9]] and means it works? #{matrix_mult([[1, 2, 3], [4, 5, 6], [7, 8 ,9]], [[1, 0, 0], [0, 1, 0], [0,0,1]]) == [[1, 2, 3], [4, 5, 6], [7, 8 ,9]]}"

puts "When n is four this method returns #{matrix_mult([[2, 0, -1], [3, 5, 2], [-4, 1 ,4]], [[5, 1, -2], [-1, 0, 4], [2,-3,3]])} which should be [[8, 5, -7], [14, -3, 20], [-13, -16 ,24]] and means it works? #{matrix_mult([[2, 0, -1], [3, 5, 2], [-4, 1 ,4]], [[5, 1, -2], [-1, 0, 4], [2,-3,3]]) == [[8, 5, -7], [14, -3, 20], [-13, -16 ,24]]}"
