require 'pry'

class PriceCalculator
  attr_reader :grocery_list, :itemized_list

  def initialize(grocery_list)
    @grocery_list  = grocery_list.split(',').map(&:strip).sort
    @itemized_list = create_itemized_list

    perform
  end

  def perform
    calculate_item_total
  end

  def calculate_item_total
    itemized_list.each do |item, quantity|
      normal_quantity = quantity
      sale_quantity = 0

      if sale_items.keys.include?(item.to_sym)
        normal_quantity = quantity % sale_items.fetch(item.to_sym, 0)[0]
        sale_quantity = quantity - normal_quantity
      end

      total = normal_quantity * store_items.fetch(item.to_sym, 0) + sale_quantity * sale_items.fetch(item.to_sym, 0)[1]

      itemized_list[item] = [quantity, total]
    end
  end

  # can use tally method in the future to make this process easier
  def create_itemized_list
    grocery_list.each_with_object(Hash.new(0)) do |item, items|
      items[item] += 1
    end
  end

  def store_items
    {
      apple: 0.89,
      banana: 0.99,
      bread: 2.17,
      milk: 3.97
    }
  end

  def sale_items
    {
      bread: [3, 2.00],
      milk: [2, 2.50]
    }
  end
end

# print "Please enter all the items purchased separated by a comma: \n"
# grocery_list = gets

# price_calculator = PriceCalculator.new(grocery_list)
