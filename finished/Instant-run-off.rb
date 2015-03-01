def runoff(voters)
  print "\nVoters are #{voters} \n"
  count = Hash.new(0)
  voters.each do |ballot|
    count[ballot[0]]+=1
  end
  most = count.sort_by {|k,v| v}[-1]
  least = count.sort_by {|k,v| v}[0]
  delete_list=[]
  puts "count is #{count}"
  if most[1] <= voters.length.to_f / 2 || (count.length > 1 && count.sort_by {|k,v| v}[-2][1] == most[1])
    voters.each_with_index do |ballot, i1|
      puts "The ballot before delete is #{ballot}"
      ballot.each do |cand|
        puts "candidate low check for #{cand}"
        if count[cand] <= least[1]
          delete_list << cand
          puts "candidate to delete: #{cand}"
        end
      end
      puts "The ballot after choosing which to delete is #{ballot} and the delete list is #{delete_list}"
    end
    delete_list.each do |cand|
      voters.each_with_index do |vote, i|
        voters[i].delete(cand)
      end
    end
    puts "The ballot votes after deleting are #{voters}"
    return runoff(voters)
  end
  most[0]
end

voters = [[:dem, :ind, :rep],
          [:rep, :ind, :dem],
          [:ind, :dem, :rep],
          [:ind, :rep, :dem]]
print runoff(voters)

voters =   [[:c, :a, :b, :d, :e],
            [:b, :e, :d, :c, :a],
            [:b, :e, :c, :a, :d],
            [:d, :b, :c, :a, :e],
            [:c, :b, :d, :a, :e]]
print runoff(voters)

voters = [[:a, :c, :b, :d, :e], [:d, :c, :a, :b, :e], [:e, :b, :d, :a, :c], [:e, :a, :b, :c, :d], [:b, :c, :e, :a, :d]]
puts "expecting :e, instead got: #{runoff(voters)}"

voters = [[:a, :c, :d, :e, :b], [:e, :b, :d, :c, :a], [:d, :e, :c, :a, :b], [:c, :e, :d, :b, :a], [:b, :e, :a, :c, :d]]
puts "expecting nil, instead got: #{runoff(voters)}"