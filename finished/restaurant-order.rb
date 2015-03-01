class Restaurant
  def initialize(menu)
    @menu = menu
    @insults = ["You idiot! Can't you read the menu?",
                "How did you manage to open the door and get into this place?",
                "GET OUT!",
                "Let's stick with the menu, shall we?"]
  end
  attr_accessor :menu
  def cost(*order)
    order.each do |food|
      messages = "" #Reset the message within each order
      sum = 0 #Reset the total order cost within each order
      food.each do |item, no|
        if @menu[item] #if we have the item on the menu, add the price * no ordered to the cost
          sum += @menu[item] * no * 10 #This gets price in pennies
        else
          item = item.to_s.chars.map{ |x| x == '_' ? ' ' : x}.join('')
          messages << "\n#{@insults[rand(@insults.length)]} We don't sell #{item}." #Adds to insult portion of the message to be returned
        end
      end
      sum = '%.2f' % (sum.round(2)/10) #Turns pennies into pounds + pence with exactly 2 dec places
      puts "Hello! Thank you for ordering. Your bill is £#{sum}.#{messages}\n\n" #prints the messages for each order with extra newlines a the end to clarify separate orders
    end
  end
end
restaurant = Restaurant.new({rice: 1, bread: 2, soy: 0.1})
restaurant.cost({rice: 2, soy: 10000, flame_grilled_pheonix: 1, sautéed_pineapple: 3, pickled_strawberry: 8})
restaurant.menu[:pickled_strawberry]=3 #They've had so many orders for pickled strawberry that they've added it to the menu.
restaurant.cost({rice: 2, soy: 10000, flame_grilled_pheonix: 1, sautéed_pineapple: 1000, pickled_strawberry: 8})
restaurant.menu[:pickled_strawberry]=5 #Pickled strawberries are so popular that they've increased the price.
restaurant.cost({rice: 2, soy: 7, flame_grilled_pheonix: 1, sautéed_pineapple: 3, pickled_strawberry: 8},{sautéed_pineapple: 1000, pickled_strawberry: 8})