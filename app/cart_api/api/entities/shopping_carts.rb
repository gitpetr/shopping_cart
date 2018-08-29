module API
  module Entities
    class ShoppingCarts < Grape::Entity
      expose :id
      expose :products, using: API::Entities::Products
    end
  end
end
