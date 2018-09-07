module API
  module Entities
    class Positions < Grape::Entity
      expose :product, merge: true, using: API::Entities::Products
      expose :quantity
    end
  end
end
