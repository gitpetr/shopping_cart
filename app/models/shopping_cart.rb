class ShoppingCart < ApplicationRecord
  has_many :positions
  has_many :products, through: :positions

  def add_product(params)
    current_product = products.find_by(id: params[:product][:id])

    if current_product
      positions = current_product.positions.find_by(shopping_cart_id: self.id)
      positions.quantity += params[:positions][:quantity].to_i
      positions.save
    else
      current_product = Product.find(params[:product][:id])
      self.products <<  current_product
      positions = current_product.positions.find_by(shopping_cart_id: self.id)
      positions.quantity = params[:positions][:quantity].to_i
      positions.save
    end
  end
end

