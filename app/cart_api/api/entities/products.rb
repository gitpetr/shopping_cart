module API
  module Entities
    class Products < Grape::Entity
      expose :id
      expose :name
      expose :description
      expose :price
      expose :positions, using: API::Entities::Positions
    end
  end
end
