module API::V1
  class ShoppingCarts < Grape::API
    version 'v1', using: :path
    resource :shopping_carts do
      desc 'Return list of shopping_carts'
      get do
        shopping_carts = ShoppingCart.all    
        present shopping_carts, with: API::Entities::ShoppingCarts
      end

      desc 'Return a specific shopping_cart'
      route_param :id do
        get do
          shopping_cart = ShoppingCart.find(params[:id])
          present shopping_cart, with: API::Entities::ShoppingCarts
        end
      end

      desc 'Create a shopping_cart.'
      params do
        requires :shopping_cart, type: Hash do
          requires :product_id
          requires :products
          requires :positions
        end
      end

      post do
      # curl -d '{"shopping_cart":{}}' 'http://localhost:3000/api/v1/shopping_carts' -H Content-Type:application/json -v
        shopping_cart = ShoppingCart.create(params[:shopping_cart])
        present shopping_cart, with: API::Entities::ShoppingCarts
      end

      desc 'Update a shopping_cart'
      patch ':id' do
      # curl -d '{"shopping_cart":{}, "product": {"id":"2", "quantity":"2"}}' 'http://localhost:3000/api/v1/shopping_carts/2' -X PATCH -H Content-Type:application/json -v
        @shopping_cart = ShoppingCart.find(params[:id])
        @shopping_cart.add_product(params)
        present @shopping_cart, with: API::Entities::ShoppingCarts
      end

      desc 'Delete a shopping_cart'
      delete ':id' do
        shopping_cart = ShoppingCart.find(params[:id])
        shopping_cart.destroy
        present shopping_carts, with: API::Entities::ShoppingCarts
      end
    end
  end
end
