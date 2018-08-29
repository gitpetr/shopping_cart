class ChangeColumnQuantityToProducts < ActiveRecord::Migration[5.2]
  def change
    change_column_default :products, :quantity, 1
  end
end
