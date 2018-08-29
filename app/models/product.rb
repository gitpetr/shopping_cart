class Product < ApplicationRecord
  has_many :positions
  has_many :shopping_carts, through: :positions
end
