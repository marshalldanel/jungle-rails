class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates :product, presence: true
  validates :users, presence: true
  validates :rating, presence: true

end
