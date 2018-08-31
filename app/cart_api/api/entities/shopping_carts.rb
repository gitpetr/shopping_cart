module API
  module Entities
    class ShoppingCarts < Grape::Entity
      expose :id
      # expose :products, using: API::Entities::Products
      expose :positions, as: :products, using: API::Entities::Positions
    end
  end
end
