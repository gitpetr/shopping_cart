module API
  module Entities
    class Positions < Grape::Entity
      expose :shopping_cart_id
      expose :product_id
      expose :quantity
    end
  end
end