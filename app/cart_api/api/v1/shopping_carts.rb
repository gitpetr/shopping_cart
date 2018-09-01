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
          requires :product_id, type: Integer
          requires :products
          requires :positions, type: Integer, default: 1, values: (1..10).to_a
        end
      end

      # curl -d '{"shopping_cart": {}}' 'http://localhost:3000/api/v1/shopping_carts' -H Content-Type:application/json -v
      post do
        shopping_cart = ShoppingCart.create(params[:shopping_cart])
        present shopping_cart, with: API::Entities::ShoppingCarts
      end

      desc 'Update a shopping_cart'
      # curl -d '{"shopping_cart": {}, "product": {"id":"2"}, "positions": {"quantity":"2"}}' 'http://localhost:3000/api/v1/shopping_carts/2' -X PATCH -H Content-Type:application/json -v
      patch ':id' do
        @shopping_cart = ShoppingCart.find(params[:id])
        @errors = @shopping_cart.add_product(params)
        @product = Product.find(params[:product][:id])
        if @errors.empty?
          present @product, with: API::Entities::Product
        else
          error!("#{@errors}")
        end
      rescue ActiveRecord::RecordNotFound => e
        error!("#{e.message}")
      end

      desc 'Delete a shopping_cart'
      # curl -d '{"shopping_cart":{}, "product": {"id":"7"}, "positions": {"quantity":"1"}}' 'http://localhost:3000/api/v1/shopping_carts/2' -X DELETE -H Content-Type:application/json -v
      delete ':id' do
        shopping_cart = ShoppingCart.find(params[:id])
        shopping_cart.delete_product(params)
        present shopping_cart, with: API::Entities::ShoppingCarts
      rescue ActiveRecord::RecordNotFound => e
        error!("#{e.message}")
      end
    end
  end
end
