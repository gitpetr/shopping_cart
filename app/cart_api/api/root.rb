module API
  class Root < Grape::API
    format :json
    mount API::V1::Products
    mount API::V1::ShoppingCarts
  end
end
