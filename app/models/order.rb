class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :sub_quantity

  def sub_quantity
    line_items.each do |line_item|
      line_item.product.quantity -= line_item.quantity
      line_item.product.save!
    end
  end

end
