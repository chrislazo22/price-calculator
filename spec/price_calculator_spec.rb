require 'price_calculator'

RSpec.describe PriceCalculator do
  describe 'format_grocery_list' do
    context 'when a valid grocery list is passed in' do
      xit 'returns the correct itemized list for one item' do
        expect(PriceCalculator.new('apple').grocery_list).to eq({ apple: 1 })
      end

      xit 'returns the correct itemized list for multiple items' do
        expect(PriceCalculator.new('apple, milk, bread, banana').grocery_list).to eq(
          { apple: 1, banana: 1, bread: 1, milk: 1 }
        )
      end

      xit 'returns the correct itemized list for multiple items' do
        expect(PriceCalculator.new('milk, bread, milk, milk').grocery_list).to eq(
          { milk: 3, bread: 1 }
        )
      end

      xit 'returns the correct quantity for specific item' do
        expect(PriceCalculator.new('milk, milk, milk').grocery_list).to eq({ milk: 3 })
      end
    end
  end

  describe '#calculate_item_total' do
    xit 'return itemized hash for one item' do
      expect(PriceCalculator.new('apple').itemized_list).to eq({ apple: [1, 0.89] })
    end

    xit 'return itemized hash for multiple items' do
      input_string = 'milk,milk, bread,banana,bread,bread,bread,milk,apple'
      expect(PriceCalculator.new(input_string).itemized_list).to eq(
        { apple: [1, 0.89], banana: [1, 0.99], bread: [4, 8.17], milk: [3, 8.97] }
      )
    end
  end
end
