class Calculator
  def evaluate(string)

    array = string.split(' ')
    array = all_mults(array)
    all_adds(array).join.to_i
  end

  def all_mults(array)
    new_array = array.each_with_index.inject([]) do |new_array, (character, position)|
      if character != "*" && array[position-1] != "*" && array[position+1] != "*" &&  character != "/" && array[position-1] != "/" && array[position+1] != "/"
        new_array << character
      elsif character == '*' && (array[position - 2] == '*' || array[position - 2] == '/')
        new_array << character
        new_array << array[position + 1]
      elsif character == '*'
        new_array << (array[position-1].to_i * array[position+1].to_i).to_s
      elsif character == '/' && (array[position - 2] == '*' || array[position - 2] == '/')
        new_array << character
        new_array << array[position + 1]
      elsif character == '/'
        new_array << (array[position-1].to_i / array[position+1].to_i).to_s
      end
      new_array
    end
    new_array.join.scan('*').length > 0 || new_array.join.scan('/').length > 0 ? all_mults(new_array) : new_array
  end


  def all_adds(array)
    new_array = array.each_with_index.inject([]) do |new_array, (character, position)|
      p new_array
      if character != "+" && array[position-1] != "+" && array[position+1] != "+" &&  character != "-" && array[position-1] != "-" && array[position+1] != "-"
        new_array << character
      elsif character == '+' && (array[position - 2] == '+' || array[position - 2] == '-')
        new_array << character
        new_array << array[position + 1]
      elsif character == '+'
        new_array << (array[position-1].to_i + array[position+1].to_i).to_s
      elsif character == '-' && (array[position - 2] == '+' || array[position - 2] == '+')
        new_array << character
        new_array << array[position + 1]
      elsif character == '-'
        new_array << (array[position-1].to_i - array[position+1].to_i).to_s
      end
      new_array
    end
    new_array.join.scan('+').length > 0 || new_array.include?('-') ? all_adds(new_array) : new_array
  end
end

puts "calc evaluates to:\n#{Calculator.new.evaluate("10 - 90 + 9 + 10 - 90")}"