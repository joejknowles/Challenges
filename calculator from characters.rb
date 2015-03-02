class Calculator

  def evaluate(string)
    string = string.split(' ')
    all_mults(string)


  end

  def all_mults(string)
    string.each_with_index.inject([]) do |new_array, (num_or_op, char_i)|
      if num_or_op == '*'
        new_array.push(string[char_i-1].to_i * string[char_i+1].to_i)
      elsif string[char_i-1] != '*' || string[char_i+1]
        new_array
      else
        new_array <<
      end

    end
  end
end




puts "#{Calculator.new.evaluate('2 * 3')}"