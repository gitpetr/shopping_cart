module API
  module Entities
    class Movie < Grape::Entity
      expose :id
      expose :title
      expose :description
      expose(:image) do |movie|
        movie.image.url(:medium)
      end
      expose :recensios, using: API::Entities::Recensios
    end
  end
end


module API
  module Entities
    class ShoppingCart < GrapeEntity
      expose :id
      # первый аргумент нам говорит, какой метод вызывать у модели (obj.positions)
      # as говорит нам, как это будет поле называться в json'e (т.е. вместо positions ключ в json'e будет products)
      expose :positions, as: :products, using: API::Entities::Posision
    end
  end
end

module API
  module Entities
    class Posision < GrapeEntity
      # merge true говорит, что всё что в этом энтити будет вмерджено в основной json
      expose :product, merge: true, using: API::Entities::Product
      expose :quantity
    end
  end
end
