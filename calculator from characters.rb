class Calculator

  def evaluate(string)
    string = string.split(' ')
    string =all_mults(string)

    #string[0].to_i
  end

  def all_mults(string)
    string = string.each_with_index.inject([]) do |new_array, (num_or_op, char_i)|
      if num_or_op == '*' && string[char_i-2] != '*'
        new_array << (string[char_i-1].to_i * string[char_i+1].to_i).to_s
      elsif char_i + 1 == string.length
        new_array
      elsif string[char_i-1] != '*' && string[char_i+1]!= '*'
        new_array << num_or_op
        new_array << string[char_i+1] if string[char_i-2] == '*'
      else
        new_array
      end
    end
    string = all_mults(string) if string.join.scan('*').length > 0
    return string
  end
end
puts "#{Calculator.new.evaluate('2 * 3 * 6 + 7 * 10')}"