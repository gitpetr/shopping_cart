module API::V1
  class Products < Grape::API
    version 'v1', using: :path
    resource :products do
      desc 'Return list of products'
      get do
        products = Product.all
        present products, with: API::Entities::Products
      end

      desc 'Return a specific product'
      route_param :id do
        get do
          product = Product.find(params[:id])
          present product, with: API::Entities::Products
        end
      end

      desc 'Create a product.'
      params do
        requires :product, type: Hash do
          requires :name
          requires :description
          requires :price
        end
      end

      post do
      # curl -d '{"product":{"name":"cart","description":"woods","price":"500", "quantity":"1"}}' 'http://localhost:3000/api/v1/products' -H Content-Type:application/json -v
        product = Product.create(params[:product])
        present product, with: API::Entities::Products
      end

      desc 'Update a product'
      patch ':id' do 
      #curl -d '{"product":{"name":"pizza","description":"organic product","price":"250", "quantity":"4"}}' -X PATCH 'http://localhost:3000/api/v1/products/4' -H Content-Type:application/json -v
        product = Product.find(params[:id])
        product.update(params[:product])
        present product, with: API::Entities::Product
      end

      desc 'Delete a product'
      # curl -X DELETE 'http://localhost:3000/api/v1/products/4' -H Content-Type:application/json -v
      delete ':id' do
        product = Product.find(params[:id])
        product.destroy
        present products, with: API::Entities::Product
      end
    end
  end
end
