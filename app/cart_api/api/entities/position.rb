module API
  module Entities
    class Position < Grape::Entity
      expose :shopping_cart_id
      expose :quantity
    end
  end
end
