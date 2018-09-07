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
        rescue ActiveRecord::RecordNotFound => e
          error!("#{e.message}")
        end
      end

      desc 'Create a product.'
      params do
        requires :product, type: Hash do
          requires :name, type: String
          requires :description
          requires :price, type: BigDecimal
        end
      end

      post do
        product = Product.create(params[:product])
        present product, with: API::Entities::Products
      end

      desc 'Update a product'
      patch ':id' do
        product = Product.find(params[:id])
        product.update(params[:product])
        present product, with: API::Entities::Products
      rescue ActiveRecord::RecordNotFound => e
        error!("#{e.message}")
      end

      desc 'Delete a product'
      delete ':id' do
        product = Product.find(params[:id])
        product.destroy
        present "{#{product.name}:'удален'}"
      rescue ActiveRecord::RecordNotFound => e
        error!("#{e.message}")
      end
    end
  end
end
