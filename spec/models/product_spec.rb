require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.new(name: "Electronics")
    end

    it 'returns true when all fields are provided' do
      @product = Product.new(name: "Smartwatch", price: 1_335.00, quantity: 11, category: @category)
      saved = @product.save
      expect(saved).to be_truthy
    end

    it 'returns false when the name field is missing' do
      @product = Product.new(name: nil, price: 1_335.00, quantity: 11, category: @category)
      saved = @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")

    end

    it 'returns false when the price field is missing' do
      @product = Product.new(name: "Smartwatch", price: nil, quantity: 11, category: @category)
      saved = @product.save
      expect(@product.errors.full_messages ).to include("Price can't be blank")
    end

    it 'returns false when the quantity field is missing' do
      @product = Product.new(name: "Smartwatch", price: 1_335.00, quantity: nil, category: @category)
      saved = @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'returns false when the category field is missing' do
      @product = Product.new(name: "Smartwatch", price: 1_335.00, quantity: 11, category: nil)
      saved = @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
