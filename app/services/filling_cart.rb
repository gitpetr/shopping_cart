module FillingCart
  def add_product(params)
    current_product = products.find_by(id: params[:product][:id])

    if current_product
      @positions = current_product.positions.find_by(shopping_cart_id: self.id)
      @positions.quantity += params[:positions][:quantity].to_i if params[:positions]
      @positions.save
      @positions.errors.full_messages
    else
      current_product = Product.find(params[:product][:id])
      self.products <<  current_product
      @positions = current_product.positions.find_by(shopping_cart_id: self.id)
      @positions.quantity = params[:positions][:quantity].to_i if params[:positions]
      @positions.save
      @positions.errors.full_messages
    end
  end

  def delete_product(params)
    product = Product.find(params[:product][:id])
    current_product = products.find_by(id: product.id)
    if current_product
      positions = current_product.positions.find_by(shopping_cart_id: self.id)
      positions.quantity -= params[:positions][:quantity].to_i if params[:positions]
      positions.quantity < 1 ? self.products.destroy(current_product) : positions.save
      nil
    else
      raise ActiveRecord::RecordNotFound, 'Такого товара в Вашей корзине нет'
    end
  end
end
