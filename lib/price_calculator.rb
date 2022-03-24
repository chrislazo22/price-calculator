require 'pry'

class PriceCalculator
  attr_reader :grocery_list, :itemized_list

  def initialize(grocery_list)
    @grocery_list  = grocery_list.split(',').map(&:strip).sort
    @itemized_list = create_itemized_list
  end

  # can use tally method in the future to make this process easier
  def create_itemized_list
    grocery_list.each_with_object(Hash.new(0)) do |item, items|
      items[item] += 1
    end
  end
end

# print "Please enter all the items purchased separated by a comma: \n"
# grocery_list = gets

# price_calculator = PriceCalculator.new(grocery_list)
