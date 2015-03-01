def pascalsTriangle(n)
   final = []
  n.times do
    final << []
  end
  final.each_with_index do |line, i|
    ind = 0
    (i+1).times do
      num = 1
      if i > 1
        if line.length > 0 && line.length < final[i-1].length
        num = final[i-1][ind] + final[i-1][ind+1]
        ind += 1
        end
      end
      final[i] << num
    end
  end
final.flatten
end