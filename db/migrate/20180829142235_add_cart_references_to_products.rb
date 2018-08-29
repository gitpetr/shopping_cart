class AddCartReferencesToProducts < ActiveRecord::Migration[5.2]
  def change
    drop_table :positions
    add_reference :products, :shopping_cart, foreign_key: true
  end
end
