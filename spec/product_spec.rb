require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
  it "should create a new product" do
    @category = Category.create(name: 'Electronics')
    @product = @category.products.create(name: 'Electric Chair', description: 'test', image: 'test', price_cents: 98765, quantity: 2)
    expect(@product).to be_valid
    @product.errors.full_messages
  end
  it "is not valid without a name" do
    @category = Category.create(name: 'Electronics')
    @product = @category.products.create(name: nil, description: 'test', image: 'test', price_cents: 98765, quantity: 2)
    expect(@product).not_to be_valid
    @product.errors.full_messages
  end
  it "is not valid without a price" do
    @category = Category.create(name: 'Electronics')
    @product = @category.products.create(name: 'HotDog Slicer', description: 'test', image: 'test', price_cents: nil, quantity: 2)
    expect(@product).not_to be_valid
    @product.errors.full_messages
  end
  it "is not valid without a quantity" do
    @category = Category.create(name: 'Electronics')
    @product = @category.products.create(name: 'Optimal Sleeping Bed', description: 'test', image: 'test', price_cents: 98765, quantity: nil)
    expect(@product).not_to be_valid
    @product.errors.full_messages
  end
  it "is not valid without a category" do
    @product = Product.create(name: 'Red Bookshelf', description: 'test', image: 'test', price_cents: 98765, quantity: 2)
    expect(@product).not_to be_valid
    @product.errors.full_messages
  end
  end
end