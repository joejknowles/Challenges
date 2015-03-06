EXPLICIT: one(plus(one))

1. two(plus(**one**))
  executes one:

  def one(operation=nil)
    return 1 if operation.nil? *(<= true)*
    operation.call(1)
  end

  operation == nil  => returns 1


2. two **plus(1)**
  executes plus(1):

  def plus(num)
    lambda { |other_num| other_num + num}
  end


  => a lambda with '1' in place of 'num' like this:
  { |other_num| other_num + 1}


3. **two(lambda { |other_num| other_num + 1})**
  executes two(lambda { |other_num| other_num + 1})

  def two(operation=nil)
    return 2 if operation.nil?  *(<= true)*
    operation.call(2)
  end

  lambda { |other_num| other_num + 1}.call(2)
  => other_num = 2

  =>  2 + 1



IMPLICIT:  one &plus(one)

1.one &plus(**one**)

  def one
    return 1 unless block_given? => false so it runs and returns 1
    yield 1
  end
  no block_given so => 1


2.two &**plus(1)**

  def plus(1)
    lambda { |other_num| other_num + num}
  end

  => a lambda with '1' in place of 'num' like this:
  { |other_num| other_num + 1}


3.two **&lambda { |other_num| other_num + 1}**

  "&" changes lambda => block

  { |other_num| other_num + 1}


4.**two { |other_num| other_num + 1}**
  def two
    return 2 unless block_given? => false so it runs and returns 1
    yield 2
  end

  yields to the block ^ passing in the number one
  => 2 + 1




