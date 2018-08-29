class ShoppingCart < ApplicationRecord
  has_many :positions
  has_many :products, through: :positions
end
