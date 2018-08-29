module API
  module Entities
    class Products < Grape::Entity
      expose :id
      expose :name
      expose :description
      expose :price
      expose :quantity
    end
  end
end
