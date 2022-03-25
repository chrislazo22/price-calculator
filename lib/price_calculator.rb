class PriceCalculator
  attr_reader :grocery_list, :itemized_list
  attr_accessor :savings, :total

  def initialize(grocery_list)
    @grocery_list  = format_grocery_list(grocery_list)
    @itemized_list = {}
    @savings       = 0
    @total         = 0

    perform
  end

  def perform
    calculate_list_total
    calculate_total
    calculate_savings

    print_receipt
  end

  def print_receipt
    puts 'Item        Quantity        Price'
    puts '--------------------------------------'

    itemized_list.each do |item, details|
      first_space = ' ' * (12 - item.size)
      second_space = ' ' * 15
      puts "#{item.capitalize}#{first_space}#{details[0]}#{second_space}$#{details[1]}"
    end

    puts ''
    puts "Total Price: $#{total}"
    puts "You saved $#{savings} today."
  end

  def calculate_list_total
    grocery_list.each do |item, quantity|
      normal_quantity = quantity
      sale_quantity = 0

      if sale_items.keys.include?(item)
        normal_quantity = quantity % sale_items.fetch(item.to_sym, 0)[0]
        sale_quantity = quantity - normal_quantity
      end

      itemized_list[item] = [quantity, item_total(normal_quantity, sale_quantity, item)]
    end
  end

  def calculate_total
    @total = itemized_list.values.map { |details| details[1] }.sum
  end

  def calculate_savings
    no_savings_cost = itemized_list.map do |item, details|
      details[0] * store_items.fetch(item, 0)
    end.sum

    @savings = (no_savings_cost - total).round(2)
  end

  def item_total(normal_quantity, sale_quantity, item)
    (normal_quantity * store_items.fetch(item, 0) +
     sale_quantity * sale_items.fetch(item, 0)[1]).round(2)
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
      bread: [3.00, 2.00],
      milk: [2.00, 2.50]
    }
  end
end

print "Please enter all the items purchased separated by a comma: \n"
grocery_list = gets.chomp
PriceCalculator.new(grocery_list)
