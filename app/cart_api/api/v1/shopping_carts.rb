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
        requires :shopping_cart, type: Hash
      end

      post do
        shopping_cart = ShoppingCart.create(params[:shopping_cart])
        present shopping_cart, with: API::Entities::ShoppingCarts
      end

      desc 'Filling a shopping_cart'
      params do
        requires :shopping_cart, type: Hash
        requires :product, type: Hash do
          requires :id
        end
        requires :positions, type: Hash do
          requires :quantity, type: Integer, default: 1, values: (1..10).to_a
        end
      end

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

      desc 'Delete a product from shopping_cart'
      delete ':id' do
        shopping_cart = ShoppingCart.find(params[:id])
        proderr = shopping_cart.delete_product(params)
        error!("#{proderr}") if proderr
      rescue ActiveRecord::RecordNotFound => e
        error!("#{e.message}")
      end
    end
  end
end
