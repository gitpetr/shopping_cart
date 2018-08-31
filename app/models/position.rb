class Position < ApplicationRecord
  belongs_to :shopping_cart
  belongs_to :product

  validates :quantity, numericality: { only_integer: true,
                                       greater_than_or_equal_to: 1,
                                       less_than_or_equal_to: 10 }
end
