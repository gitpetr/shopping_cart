module API
  module Entities
    class Positions < Grape::Entity
      # expose :shopping_cart_id
      # expose :product_id
      expose :product, merge: true, using: API::Entities::Products
      expose :quantity
    end
  end
end