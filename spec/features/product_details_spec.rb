require 'rails_helper'

RSpec.feature 'ProductDetails', type: :feature do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |_n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
      @product = @category.products.first
    end
  end
  
  scenario 'Users see product details when clicking on a product' do
    # ACT
    visit root_path
    click_on "#{@product.name}"
    visit "/products/#{@product.id}"
    
    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_content "#{@product.description}"
  end
end
