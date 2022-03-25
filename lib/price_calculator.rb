require 'pry'

class PriceCalculator
  attr_reader :grocery_list, :itemized_list

  def initialize(grocery_list)
    @grocery_list = format_grocery_list(grocery_list)
    @itemized_list = {}

    perform
  end

  def perform
    calculate_list_total
  end

  def calculate_list_total
    grocery_list.each do |item, quantity|
      normal_quantity = quantity
      sale_quantity = 0

      if sale_items.keys.include?(item.to_sym)
        normal_quantity = quantity % sale_items.fetch(item.to_sym, 0)[0]
        sale_quantity = quantity - normal_quantity
      end

      itemized_list[item] = [quantity, item_total(normal_quantity, sale_quantity, item)]
    end
  end

  def item_total(normal_quantity, sale_quantity, item)
    normal_quantity * store_items.fetch(item, 0) + sale_quantity * sale_items.fetch(item, 0)[1]
  end

  def format_grocery_list(grocery_list)
    grocery_list.split(',').map do |item|
      item.strip.downcase.to_sym
    end.tally
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
