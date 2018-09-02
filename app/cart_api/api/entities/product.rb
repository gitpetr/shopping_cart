module API
  module Entities
    class Product < Grape::Entity
      expose :id
      expose :name
      expose :description
      expose :price
      expose :positions, using: API::Entities::Position
    end
  end
end
