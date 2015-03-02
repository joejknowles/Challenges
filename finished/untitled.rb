def dasherize_number(number)
  number = number.to_s.chars
  number.each_with_index.inject([]) do |array, (el, index)|
    array << el
    if (index + 1) == number.length
      array
    elsif el.to_i.odd? || number[index+1].to_i.odd?
      array << '-'
    end
    array
  end.join
end


print dasherize_number(1217668322425623)