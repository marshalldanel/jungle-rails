require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After placing the order' do
    before :each do
      @user = User.create(
        first_name: 'Bob',
        last_name: 'Bob',
        email: 'bob@bob.com',
        password: '12345678',
        password_confirmation: '12345678'
      )

      @category = Category.create name: 'Stuff'
      # Setup at least two products with different quantities, names, etc
      @starting_quantity = 32
      @product1 = Product.create! name: 'World\'s Mediumest Smartwatch', quantity: @starting_quantity, price: 1_000.29, category: @category
      @product2 = Product.create! name: 'World\'s Smallest Smartwatch', quantity: @starting_quantity, price: 500.29, category: @category
      # Setup at least one product that will NOT be in the order
      @product3 = Product.create! name: 'World\'s Largest Smartwatch', quantity: @starting_quantity, price: 2_000.29, category: @category
    
      def create_new_order
        # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)        
        @order = Order.new(
          user: @user,
          stripe_charge_id: 'something',
          total_cents: @product1.price + @product2.price
        )
        # Initialize order quantity
        @order_quantity = 1
        # 2. build line items on @order
        @order.line_items.new(
          product: @product1,
          quantity: @order_quantity,
          item_price: @product1.price,
          total_price: @product1.price * @order_quantity
        )
        @order.line_items.new(
          product: @product2,
          quantity: @order_quantity,
          item_price: @product2.price,
          total_price: @product2.price * @order_quantity
        )
        # 3. save! the order
        @order.save!
      end
    end

    it 'deducts quantity from products based on their line item quantities' do
      create_new_order
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec to assert their new quantity values
      expect(@product1.quantity).to eq(@starting_quantity - @order_quantity)
      expect(@product2.quantity).to eq(@starting_quantity - @order_quantity)
    end

    it 'does not deduct quantity from products that are not in the order' do
      create_new_order
      @product3.reload
      expect(@product3.quantity).to eq(@starting_quantity)
    end
  end
end
