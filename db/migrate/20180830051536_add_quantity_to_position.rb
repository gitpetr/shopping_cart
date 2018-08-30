class AddQuantityToPosition < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :quantity
    add_column :positions, :quantity, :integer, default: 1
  end
end
