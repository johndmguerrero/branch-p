class CreateProductItems < ActiveRecord::Migration[7.0]
  def change
    create_table :product_items do |t|
      t.references :order_item
      t.references :product
      t.integer :quantity
      t.timestamps
    end
  end
end
