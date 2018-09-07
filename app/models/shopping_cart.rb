class ShoppingCart < ApplicationRecord
  include FillingCart
  has_many :positions
  has_many :products, through: :positions
end
