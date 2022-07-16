class CreateInventoryItems < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_items do |t|
      t.references :product
      t.references :inventory
      t.integer :quantity
      t.integer :status
      t.integer :damaged
      t.integer :undelivered
      t.timestamps
    end
  end
end
