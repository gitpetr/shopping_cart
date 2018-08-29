class ShoppingCart < ApplicationRecord
  has_many :products

  def add_product(params)
    current_product = products.find_by(id: params[:product][:id])

    if current_product
      current_product.quantity += params[:product][:quantity].to_i
      current_product.save
    else
      self.products << Product.find(params[:product][:id])
    end
  end
end

