require 'rails_helper'

RSpec.feature "Visitor navigates to product detail page", type: :feature, js: true do
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
  
  scenario "They see product details by clicking the img/product title" do
    
    visit root_path
  
    first('article.product').find('header > a').click

    sleep(2)

    expect(page).to have_css 'section.products-show'
  end

  scenario "They see the product details by clicking the 'Details' button" do
    
    visit root_path
  
    first('article.product').find_link('Details').click

    sleep(2)

    expect(page).to have_css 'section.products-show'
  end

end
