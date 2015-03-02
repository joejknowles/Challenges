def validation(string)
  length = string.length
  empty = ''
  length.times{ empty << ' '} if length > 0
  if string == empty
    return 1
  elsif !(string.strip =~ /\D/) && string.to_i.to_s.length < 9
    return string.to_i + 1
  end
  'invalid'
end
puts validation('       ') == 1
puts validation(' 112222223 ') == 112222224
puts validation('abc4') == 'invalid'



=begin

This method accepts a single argument, a string to be validated.

The string can be of any length and have any contents. But to be considered valid, it must have zero or more blanks followed by zero to eight numeric digits followed by, again, zero or more blanks.

If it is valid, the number within the string + 1 is returned. Otherwise, the string 'invalid' is returned. A completely blank string is considered valid, equal to zero.

'   7   '     returns 8

'   2 8   '     returns 'invalid' (there mustn't be any spaces (or any other characters) between digits

'     a  8 '     returns 'invalid'

'    ' returns 1

'abc1' returns 'invalid'

An easy problem.

The only slight challenge is to produce a simple method that has no regular expressions and no nesting; no explict nesting with 'for' or 'while' or whatever, no block nesting with things like 'map' or 'each'; obviously I have no way of enforcing this!
=end