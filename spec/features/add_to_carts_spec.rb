require 'rails_helper'

RSpec.feature "Visitor adds product to carts", type: :feature, js: true do
  before :each do
    category = Category.create! name: 'Apparel'

    @thing = category.products.create!(
      name: Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
  end

  scenario "They see 'My Cart()' increase by 1 after clicking 'Add' button" do
    visit root_path
    first('article.product').find_link('Add').click
    expect(page).to have_content 'My Cart (1)'
  end
  
end
