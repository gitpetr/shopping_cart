class Product < ApplicationRecord
  has_many :positions, dependent: :destroy
  has_many :shopping_carts, through: :positions
end
