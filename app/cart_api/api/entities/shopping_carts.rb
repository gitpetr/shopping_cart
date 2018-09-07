module API
  module Entities
    class ShoppingCarts < Grape::Entity
      expose :id
      expose :positions, as: :products, using: API::Entities::Positions
    end
  end
end
