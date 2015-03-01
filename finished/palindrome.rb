def palindrome(string)
  string = string.downcase.chars.keep_if{|x| x.ord > 96 && x.ord < 123}
  (0...string.length).each do |i|
    unless string[i] == string[string.length - (1 + i)]
      return false
    end
  end
  true
end
puts palindrome('heel.lo,oo7 lleeh')