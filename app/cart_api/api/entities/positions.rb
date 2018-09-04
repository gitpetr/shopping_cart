module API
  module Entities
    class Positions < Grape::Entity
      # merge true говорит, что всё что в этом энтити будет вмерджено в основной json
      expose :product, merge: true, using: API::Entities::Products
      expose :quantity
    end
  end
end
