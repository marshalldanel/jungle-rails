require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  
  before :each do
    @user = User.create ({
      first_name: 'Bob',
      last_name: 'Bob',
      email: 'bob@bob.com',
      password: '12345678',
      password_confirmation: '12345678'
    })
  end

  scenario "They see product details by clicking the img/product title" do
    visit root_path
    find_link('Login').click

    find 'form' do
      fill_in id: 'email', with: @user.email
      fill_in id: 'password', with: @user.password

      click_button 'Submit'
    end
    
    expect(page).to have_content 'Logout'
  end
end
