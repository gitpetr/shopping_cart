module API
  module Entities
    class ShoppingCarts < Grape::Entity
      expose :id
      # первый аргумент нам говорит, какой метод вызывать у модели (obj.positions)
      # as говорит нам, как это будет поле называться в json'e (т.е. вместо positions ключ в json'e будет products)
      expose :positions, as: :products, using: API::Entities::Positions
    end
  end
end
