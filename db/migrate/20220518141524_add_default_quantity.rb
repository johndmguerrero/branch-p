class AddDefaultQuantity < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :quantity, :integer, default: 0
  end
end
