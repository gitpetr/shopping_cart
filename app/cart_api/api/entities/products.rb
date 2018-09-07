module API
  module Entities
    class Products < Grape::Entity
      expose :id
      expose :name
      expose :description
      expose :price
    end
  end
end
