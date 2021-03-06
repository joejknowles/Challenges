class Calculator

  def evaluate(string)
    string = string.split(' ')

    string.each_with_index.inject([]) do |new_array, (num_or_op, char_i)|
      if num_or_op == '*'
        new_array.push(string[char_i-1].to_i * string[char_i+1].to_i)
      end
      new_array
    end

  end

end
puts "#{Calculator.new.evaluate('2 * 3')}"