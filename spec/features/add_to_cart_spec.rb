require 'rails_helper'

RSpec.feature 'AddToCarts', type: :feature do
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
    end
  end
  scenario 'My cart count increases by 1 every time add button is clicked' do
    # ACT
    visit root_path
    page.find('button.btn-primary', match: :first).click
    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_content "My Cart (1)"
  end
end
