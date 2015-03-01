def solution(list)
  list.sort
  final = []
  list.each_with_index do |x, i|
    if (x - 1) == list[i-1] && (x - 1) == list[i-1] #tests current value consecutive to previous, move on as already dealt with
      next
    elsif x + 1 < list[i +1 ] # if next isn't consecutive, push current
      final.push("#{x}")
    elsif i == (list.length - 1) # if on the last element: push it
      final.push("#{x}")
    elsif x + 2 < list[i +2 ] #if two elements along is not consecutive- push current and next
      final.push("#{x}")
      final.push("#{x + 1}")
    else
      fol=1
      last = x
      while (x + fol) == list[i+fol]
        fol +=1
        last +=1
      end
      final.push("#{x}-#{last}")
    end
  end
  final.join(',')
end

print solution([-6, -3, -1, 0, 1, 3, 4, 5, 7, 8, 9, 10, 11, 14, 15, 17, 18, 19, 20])