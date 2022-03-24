require 'price_calculator'

RSpec.describe PriceCalculator do
  describe '#create_grocery_items' do
    context 'when a valid grocery list is passed in' do
      it 'returns the correct itemized list for one item' do
        expect(PriceCalculator.new('apple').itemized_list).to eq({ 'apple' => 1 })
      end

      it 'returns the correct itemized list for multiple items' do
        expect(PriceCalculator.new('apple, milk, bread, bananas').itemized_list).to eq(
          {
            'apple' => 1,
            'bananas' => 1,
            'bread' => 1,
            'milk' => 1
          }
        )
      end

      it 'returns the correct itemized list for multiple items' do
        expect(PriceCalculator.new('milk, bread, milk, milk').itemized_list).to eq(
          {
            'bread' => 1,
            'milk' => 3
          }
        )
      end

      it 'returns the correct quantity for specific item' do
        expect(PriceCalculator.new('milk, milk, milk').itemized_list['milk']).to eq(3)
      end
    end
  end
end
