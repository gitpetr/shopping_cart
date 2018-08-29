module API
  class Root < Grape::API
    format :json
    mount API::V1::Products
    mount API::V1::ShoppingCart
    mount API::V1::Position
  end
end
